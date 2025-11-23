#include <stdlib.h>

typedef struct {
    int* arr;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->arr = (int*)malloc(stack->capacity * sizeof(int));
    stack->top = -1;
    return stack;
}

void push(Stack* stack, int item) {
    stack->arr[++stack->top] = item;
}

int pop(Stack* stack) {
    return stack->arr[stack->top--];
}

int peek(Stack* stack) {
    return stack->arr[stack->top];
}

int isEmpty(Stack* stack) {
    return stack->top == -1;
}

void freeStack(Stack* stack) {
    free(stack->arr);
    free(stack);
}

int* dailyTemperatures(int* temperatures, int temperaturesSize, int* returnSize) {
    *returnSize = temperaturesSize;
    int* result = (int*)calloc(temperaturesSize, sizeof(int));

    Stack* stack = createStack(temperaturesSize);

    for (int i = 0; i < temperaturesSize; i++) {
        while (!isEmpty(stack) && temperatures[i] > temperatures[peek(stack)]) {
            int prev_index = pop(stack);
            result[prev_index] = i - prev_index;
        }
        push(stack, i);
    }

    freeStack(stack);
    return result;
}