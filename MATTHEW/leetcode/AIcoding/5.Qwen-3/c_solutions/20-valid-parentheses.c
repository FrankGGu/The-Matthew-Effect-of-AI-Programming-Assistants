#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack *s = (Stack*)malloc(sizeof(Stack));
    s->data = (char*)malloc(capacity * sizeof(char));
    s->top = -1;
    s->capacity = capacity;
    return s;
}

void push(Stack *s, char c) {
    if (s->top < s->capacity - 1) {
        s->data[++s->top] = c;
    }
}

char pop(Stack *s) {
    if (s->top >= 0) {
        return s->data[s->top--];
    }
    return '\0';
}

int isEmpty(Stack *s) {
    return s->top == -1;
}

int isValid(char *s) {
    int len = strlen(s);
    Stack *stack = createStack(len);

    for (int i = 0; i < len; i++) {
        char c = s[i];
        if (c == '(' || c == '{' || c == '[') {
            push(stack, c);
        } else {
            if (isEmpty(stack)) return 0;
            char top = pop(stack);
            if ((c == ')' && top != '(') || (c == '}' && top != '{') || (c == ']' && top != '[')) {
                return 0;
            }
        }
    }

    return isEmpty(stack);
}