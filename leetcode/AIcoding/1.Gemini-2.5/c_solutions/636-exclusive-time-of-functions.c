#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct {
    int* arr;
    int top;
    int capacity;
} Stack;

void stack_init(Stack* s, int capacity) {
    s->arr = (int*)malloc(capacity * sizeof(int));
    s->top = -1;
    s->capacity = capacity;
}

void stack_push(Stack* s, int val) {
    s->arr[++s->top] = val;
}

int stack_pop(Stack* s) {
    return s->arr[s->top--];
}

int stack_peek(Stack* s) {
    return s->arr[s->top];
}

int stack_is_empty(Stack* s) {
    return s->top == -1;
}

void stack_free(Stack* s) {
    free(s->arr);
}

int* exclusiveTime(int n, char **logs, int logsSize, int* returnSize) {
    int* ans = (int*)calloc(n, sizeof(int));
    *returnSize = n;

    Stack s;
    stack_init(&s, n);

    int prev_timestamp = 0; 
    int func_id, timestamp;
    char type_str[10];

    for (int i = 0; i < logsSize; i++) {
        sscanf(logs[i], "%d:%[^:]:%d", &func_id, type_str, &timestamp);

        if (strcmp(type_str, "start") == 0) {
            if (!stack_is_empty(&s)) {
                ans[stack_peek(&s)] += timestamp - prev_timestamp;
            }
            stack_push(&s, func_id);
            prev_timestamp = timestamp;
        } else {
            ans[stack_pop(&s)] += timestamp - prev_timestamp + 1;
            prev_timestamp = timestamp + 1;
        }
    }

    stack_free(&s);
    return ans;
}