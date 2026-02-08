#include <stdlib.h> // For malloc, free

typedef struct {
    int* data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->data = (int*)malloc(sizeof(int) * capacity);
    return stack;
}

void push(Stack* stack, int item) {
    stack->data[++stack->top] = item;
}

int pop(Stack* stack) {
    return stack->data[stack->top--];
}

int peek(Stack* stack) {
    return stack->data[stack->top];
}

int isEmpty(Stack* stack) {
    return stack->top == -1;
}

void freeStack(Stack* stack) {
    free(stack->data);
    free(stack);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int largestRectangleArea(int* heights, int heightsSize) {
    if (heightsSize == 0) {
        return 0;
    }

    Stack* stack = createStack(heightsSize); 
    int max_area = 0;

    for (int i = 0; i <= heightsSize; i++) {
        int current_height = (i == heightsSize) ? 0 : heights[i];

        while (!isEmpty(stack) && heights[peek(stack)] >= current_height) {
            int h_idx = pop(stack);
            int height = heights[h_idx];

            int width = isEmpty(stack) ? i : i - peek(stack) - 1;

            max_area = max(max_area, height * width);
        }
        push(stack, i);
    }

    freeStack(stack);
    return max_area;
}