#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->data = (char*)malloc(stack->capacity * sizeof(char));
    return stack;
}

bool isFull(Stack* stack) {
    return stack->top == stack->capacity - 1;
}

bool isEmpty(Stack* stack) {
    return stack->top == -1;
}

void push(Stack* stack, char item) {
    if (isFull(stack)) return;
    stack->data[++stack->top] = item;
}

char pop(Stack* stack) {
    if (isEmpty(stack)) return '\0';
    return stack->data[stack->top--];
}

char peek(Stack* stack) {
    if (isEmpty(stack)) return '\0';
    return stack->data[stack->top];
}

bool parseBoolExpr(char * expression){
    Stack* ops = createStack(strlen(expression));
    Stack* vals = createStack(strlen(expression));

    for (int i = 0; expression[i] != '\0'; i++) {
        char c = expression[i];

        if (c == ')') {
            int tCount = 0;
            int fCount = 0;
            while (peek(vals) != '(') {
                if (pop(vals) == 't') tCount++;
                else fCount++;
            }
            pop(vals); 

            char op = pop(ops);

            if (op == '&') {
                push(vals, (fCount == 0) ? 't' : 'f');
            } else if (op == '|') {
                push(vals, (tCount > 0) ? 't' : 'f');
            } else {
                push(vals, (tCount > 0) ? 'f' : 't');
            }
        } else if (c == 't' || c == 'f' || c == '(') {
            push(vals, c);
        } else if (c == '!' || c == '&' || c == '|') {
            push(ops, c);
        }
    }

    bool result = (pop(vals) == 't');
    free(ops->data);
    free(ops);
    free(vals->data);
    free(vals);
    return result;
}