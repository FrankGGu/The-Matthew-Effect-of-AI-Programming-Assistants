#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MAX_STACK_SIZE 1000

typedef struct {
    int top;
    int data[MAX_STACK_SIZE];
} Stack;

void push(Stack *s, int value) {
    if (s->top < MAX_STACK_SIZE - 1) {
        s->data[++s->top] = value;
    }
}

int pop(Stack *s) {
    if (s->top >= 0) {
        return s->data[s->top--];
    }
    return 0;
}

int evalRPN(char** tokens, int tokensSize) {
    Stack s;
    s.top = -1;
    for (int i = 0; i < tokensSize; i++) {
        char *token = tokens[i];
        if (isdigit(token[0]) || (token[0] == '-' && strlen(token) > 1)) {
            push(&s, atoi(token));
        } else {
            int b = pop(&s);
            int a = pop(&s);
            switch (token[0]) {
                case '+': push(&s, a + b); break;
                case '-': push(&s, a - b); break;
                case '*': push(&s, a * b); break;
                case '/': push(&s, a / b); break;
            }
        }
    }
    return pop(&s);
}