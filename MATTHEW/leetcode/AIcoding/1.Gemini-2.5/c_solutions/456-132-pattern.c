#include <stdbool.h>
#include <limits.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int top;
    int capacity;
} Stack;

void initStack(Stack* s, int capacity) {
    s->data = (int*)malloc(sizeof(int) * capacity);
    s->top = -1;
    s->capacity = capacity;
}

void freeStack(Stack* s) {
    free(s->data);
    s->data = NULL;
    s->top = -1;
    s->capacity = 0;
}

bool isEmpty(Stack* s) {
    return s->top == -1;
}

void push(Stack* s, int val) {
    s->data[++(s->top)] = val;
}

int pop(Stack* s) {
    return s->data[(s->top)--];
}

int peek(Stack* s) {
    return s->data[s->top];
}

bool find132pattern(int* nums, int numsSize) {
    if (numsSize < 3) {
        return false;
    }

    Stack s;
    initStack(&s, numsSize);

    int s3 = INT_MIN;

    for (int i = numsSize - 1; i >= 0; i--) {
        if (nums[i] < s3) {
            freeStack(&s);
            return true;
        }

        while (!isEmpty(&s) && nums[i] > peek(&s)) {
            s3 = pop(&s);
        }

        push(&s, nums[i]);
    }

    freeStack(&s);
    return false;
}