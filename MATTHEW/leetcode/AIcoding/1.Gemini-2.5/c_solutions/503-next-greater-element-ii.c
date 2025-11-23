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

void push(Stack* s, int val) {
    if (s->top < s->capacity - 1) {
        s->data[++s->top] = val;
    }
}

int pop(Stack* s) {
    if (s->top >= 0) {
        return s->data[s->top--];
    }
    return -1; 
}

int peek(Stack* s) {
    if (s->top >= 0) {
        return s->data[s->top];
    }
    return -1;
}

int isEmpty(Stack* s) {
    return s->top == -1;
}

void freeStack(Stack* s) {
    free(s->data);
    s->data = NULL;
    s->top = -1;
    s->capacity = 0;
}

int* nextGreaterElements(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* ans = (int*)malloc(sizeof(int) * numsSize);

    for (int i = 0; i < numsSize; i++) {
        ans[i] = -1;
    }

    Stack s;
    initStack(&s, numsSize);

    for (int i = 2 * numsSize - 1; i >= 0; i--) {
        int current_idx = i % numsSize;
        int current_num = nums[current_idx];

        while (!isEmpty(&s) && nums[peek(&s)] <= current_num) {
            pop(&s);
        }

        if (i < numsSize) { 
            if (!isEmpty(&s)) {
                ans[current_idx] = nums[peek(&s)];
            }
        }

        push(&s, current_idx);
    }

    freeStack(&s);
    return ans;
}