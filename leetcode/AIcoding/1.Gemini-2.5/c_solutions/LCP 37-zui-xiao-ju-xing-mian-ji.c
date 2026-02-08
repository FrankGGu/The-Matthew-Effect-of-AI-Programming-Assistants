#include <stdlib.h>

typedef struct {
    int* arr;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->arr = (int*)malloc(stack->capacity * sizeof(int));
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

int largestRectangleArea(int* heights, int heightsSize) {
    Stack* stack = createStack(heightsSize + 2); 
    int max_area = 0;
    int i = 0;

    push(stack, -1); 

    while (i <= heightsSize) { 
        int current_height = (i == heightsSize) ? 0 : heights[i];

        while (peek(stack) != -1 && current_height < heights[peek(stack)]) {
            int top_idx = pop(stack);
            int height = heights[top_idx];
            int width = i - peek(stack) - 1; 
            int current_area = height * width;
            if (current_area > max_area) {
                max_area = current_area;
            }
        }
        push(stack, i);
        i++;
    }

    freeStack(stack);
    return max_area;
}