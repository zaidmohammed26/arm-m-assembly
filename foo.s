.equ SYSTICK_CSR, 0xE000E010
.equ SYSTICK_RVR, 0xE000E014
.equ SYSTICK_CVR, 0xE000E018
.equ SYSTICK_CALIB, 0xE000E01C
.equ TIMEOUT, 0x00ffffff

.section .vectors
vector_table:
    .word 0x20001000
    .word reset_handler
    .org 0x003c
    .word systick_handler
    .zero 400

    .section .text
        .align 1
        .type reset_handler, %function

reset_handler:
    mov r5, #0x3
    push {r5}
    pop {r5}

    ldr r0, =SYSTICK_CSR
    ldr r1, =SYSTICK_RVR
    ldr r2, =SYSTICK_CVR
    ldr r3, =TIMEOUT

    str r3, [r1]
    mov	r3, #0x0
    str r3, [r2]
    mov r3, #0x7
    str r3, [r0]

    b .



    .section .text
        .align 1
        .type systick_handler, %function

systick_handler:

    push {r4-r7}

    mov r0, r8
    mov r1, r9
    mov r2, r10
    mov r3, r11

    push {r0-r3}

magic:
    pop {r0-r3}

    mov r8, r0
    mov r9, r1
    mov r10, r2
    mov r11, r3

    pop {r4-r7}

    bx lr

    .section .text
    .p2align 4
    .globl main1
    .type main1, %function

    main1:
    NOP
    add r0, r0, #1
    b main1

    .section .text
    .p2align 4
    .globl main2
    .type main2, %function

    main2:
    NOP
    add r1, r1, #2
    b main2

    .section .text
    .p2align 4
    .globl main3
    .type main3, %function

    main3:
    NOP
    add r2, r2, #3
    b main3

    .data
    .align 4

stack_1:
    .word 0x18
    .word 0x19
    .word 0x1a
    .word 0x1b
    .word 0x14
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x1c
    .word 0x309
    .word main1
    .word 0x01000000
    .zero 64
    .align 4

stack_2:
    .word 0x28
    .word 0x29
    .word 0x2a
    .word 0x2b
    .word 0x24
    .word 0x25
    .word 0x26
    .word 0x27
    .word 0x20
    .word 0x21
    .word 0x22
    .word 0x23
    .word 0x2c
    .word 0x309
    .word main2
    .word 0x01000000
    .zero 64
    .align 4

stack_3:
    .word 0x38
    .word 0x39
    .word 0x3a
    .word 0x3b
    .word 0x34
    .word 0x35
    .word 0x36
    .word 0x37
    .word 0x30
    .word 0x31
    .word 0x32
    .word 0x33
    .word 0x3c
    .word 0x309
    .word main3
    .word 0x01000000

