#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->data = (int*)malloc(capacity * sizeof(int));
    stack->top = -1;
    stack->capacity = capacity;
    return stack;
}

void push(Stack* stack, int value) {
    if (stack->top >= stack->capacity - 1) {
        return;
    }
    stack->data[++stack->top] = value;
}

int pop(Stack* stack) {
    if (stack->top < 0) {
        return -1;
    }
    return stack->data[stack->top--];
}

int isEmpty(Stack* stack) {
    return stack->top == -1;
}

int isFull(Stack* stack) {
    return stack->top == stack->capacity - 1;
}

int getTop(Stack* stack) {
    if (isEmpty(stack)) {
        return -1;
    }
    return stack->data[stack->top];
}

void freeStack(Stack* stack) {
    free(stack->data);
    free(stack);
}

int isHappy(int n) {
    Stack* seen = createStack(100);
    while (n != 1 && !isFull(seen)) {
        push(seen, n);
        int sum = 0;
        while (n > 0) {
            int digit = n % 10;
            sum += digit * digit;
            n /= 10;
        }
        n = sum;
        int top = getTop(seen);
        if (top == n) {
            freeStack(seen);
            return 0;
        }
    }
    freeStack(seen);
    return n == 1;
}

int countHappyStudents(int* students, int studentsSize) {
    int count = 0;
    for (int i = 0; i < studentsSize; i++) {
        if (isHappy(students[i])) {
            count++;
        }
    }
    return count;
}