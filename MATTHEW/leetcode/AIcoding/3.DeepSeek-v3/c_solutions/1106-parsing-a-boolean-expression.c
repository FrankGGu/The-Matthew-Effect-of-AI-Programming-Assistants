#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct {
    char *data;
    int top;
} Stack;

void initStack(Stack *s, int size) {
    s->data = (char *)malloc(size * sizeof(char));
    s->top = -1;
}

void push(Stack *s, char c) {
    s->data[++(s->top)] = c;
}

char pop(Stack *s) {
    return s->data[(s->top)--];
}

char top(Stack *s) {
    return s->data[s->top];
}

bool isEmpty(Stack *s) {
    return s->top == -1;
}

void freeStack(Stack *s) {
    free(s->data);
}

bool parseBoolExpr(char* expression) {
    Stack stack;
    int len = strlen(expression);
    initStack(&stack, len);

    for (int i = 0; i < len; i++) {
        char c = expression[i];
        if (c == ')') {
            bool hasTrue = false;
            bool hasFalse = false;

            while (top(&stack) != '(') {
                char val = pop(&stack);
                if (val == 't') hasTrue = true;
                if (val == 'f') hasFalse = true;
            }
            pop(&stack); // remove '('

            char op = pop(&stack);
            bool result;

            if (op == '!') {
                result = hasFalse; // if we had false, then !false = true
            } else if (op == '&') {
                result = !hasFalse; // AND: true only if no false
            } else { // '|'
                result = hasTrue; // OR: true if any true
            }

            push(&stack, result ? 't' : 'f');
        } else if (c != ',') {
            push(&stack, c);
        }
    }

    bool result = (top(&stack) == 't');
    freeStack(&stack);
    return result;
}