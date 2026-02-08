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
    stack->data = (char*)malloc(capacity * sizeof(char));
    stack->top = -1;
    stack->capacity = capacity;
    return stack;
}

void push(Stack* stack, char c) {
    if (stack->top < stack->capacity - 1) {
        stack->data[++stack->top] = c;
    }
}

char pop(Stack* stack) {
    if (stack->top >= 0) {
        return stack->data[stack->top--];
    }
    return '\0';
}

char peek(Stack* stack) {
    if (stack->top >= 0) {
        return stack->data[stack->top];
    }
    return '\0';
}

int isEmpty(Stack* stack) {
    return stack->top == -1;
}

void freeStack(Stack* stack) {
    free(stack->data);
    free(stack);
}

char* tagValidator(char* content) {
    int len = strlen(content);
    Stack* stack = createStack(len);
    int i = 0;
    while (i < len) {
        if (content[i] == '<') {
            if (i + 1 < len && content[i + 1] == '/') {
                i += 2;
                int j = i;
                while (j < len && content[j] != '>') {
                    j++;
                }
                if (j >= len) {
                    freeStack(stack);
                    return "False";
                }
                int tagLen = j - i;
                char* tag = (char*)malloc((tagLen + 1) * sizeof(char));
                strncpy(tag, content + i, tagLen);
                tag[tagLen] = '\0';
                if (isEmpty(stack) || strcmp(tag, &peek(stack)) != 0) {
                    free(tag);
                    freeStack(stack);
                    return "False";
                }
                pop(stack);
                i = j + 1;
            } else if (content[i + 1] != '!') {
                i += 1;
                int j = i;
                while (j < len && content[j] != '>') {
                    j++;
                }
                if (j >= len) {
                    freeStack(stack);
                    return "False";
                }
                int tagLen = j - i;
                char* tag = (char*)malloc((tagLen + 1) * sizeof(char));
                strncpy(tag, content + i, tagLen);
                tag[tagLen] = '\0';
                for (int k = 0; k < tagLen; k++) {
                    if (!(('A' <= tag[k] && tag[k] <= 'Z') || ('a' <= tag[k] && tag[k] <= 'z'))) {
                        free(tag);
                        freeStack(stack);
                        return "False";
                    }
                }
                push(stack, tag[0]);
                free(tag);
                i = j + 1;
            } else {
                i += 2;
                int j = i;
                while (j < len && content[j] != '>') {
                    j++;
                }
                if (j >= len) {
                    freeStack(stack);
                    return "False";
                }
                i = j + 1;
            }
        } else {
            i++;
        }
    }
    if (!isEmpty(stack)) {
        freeStack(stack);
        return "False";
    }
    freeStack(stack);
    return "True";
}