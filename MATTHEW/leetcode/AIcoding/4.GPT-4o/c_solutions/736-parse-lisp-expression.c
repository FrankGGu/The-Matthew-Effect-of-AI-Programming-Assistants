#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char *data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack *stack = (Stack *)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->data = (char *)malloc(capacity * sizeof(char));
    return stack;
}

int isFull(Stack *stack) {
    return stack->top == stack->capacity - 1;
}

int isEmpty(Stack *stack) {
    return stack->top == -1;
}

void push(Stack *stack, char item) {
    if (!isFull(stack)) {
        stack->data[++stack->top] = item;
    }
}

char pop(Stack *stack) {
    if (!isEmpty(stack)) {
        return stack->data[stack->top--];
    }
    return '\0';
}

char peek(Stack *stack) {
    return stack->data[stack->top];
}

void freeStack(Stack *stack) {
    free(stack->data);
    free(stack);
}

int eval(char* expr) {
    int n = strlen(expr);
    Stack *stack = createStack(n);
    int i = 0;

    while (i < n) {
        if (isspace(expr[i])) {
            i++;
            continue;
        }

        if (expr[i] == '(') {
            push(stack, expr[i]);
        } else if (expr[i] == ')') {
            int value = 0;
            while (!isEmpty(stack) && peek(stack) != '(') {
                value += pop(stack) - '0';
            }
            pop(stack); // Pop the '('
            push(stack, value + '0');
        } else if (isdigit(expr[i])) {
            push(stack, expr[i]);
        }
        i++;
    }

    int result = 0;
    while (!isEmpty(stack)) {
        result += pop(stack) - '0';
    }
    freeStack(stack);
    return result;
}

char* parseLispExpression(char* expression) {
    int result = eval(expression);
    char *output = (char *)malloc(20 * sizeof(char));
    sprintf(output, "%d", result);
    return output;
}