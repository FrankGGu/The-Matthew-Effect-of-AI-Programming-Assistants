#include <stdlib.h>

typedef struct {
    int* data;
    int top;
    int capacity;
} Stack;

void stack_init(Stack* s, int capacity) {
    s->data = (int*)malloc(sizeof(int) * capacity);
    s->top = -1;
    s->capacity = capacity;
}

void stack_push(Stack* s, int val) {
    s->data[++s->top] = val;
}

int stack_pop(Stack* s) {
    return s->data[s->top--];
}

int stack_peek(Stack* s) {
    return s->data[s->top];
}

int stack_is_empty(Stack* s) {
    return s->top == -1;
}

void stack_free(Stack* s) {
    free(s->data);
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maximumSumOfHeights(int* maxHeights, int maxHeightsSize) {
    int n = maxHeightsSize;
    long long* prefix_sum = (long long*)malloc(sizeof(long long) * n);
    long long* suffix_sum = (long long*)malloc(sizeof(long long) * n);

    Stack s;
    stack_init(&s, n);

    for (int i = 0; i < n; ++i) {
        while (!stack_is_empty(&s) && maxHeights[stack_peek(&s)] > maxHeights[i]) {
            stack_pop(&s);
        }
        int prev_idx = stack_is_empty(&s) ? -1 : stack_peek(&s);
        long long current_height = maxHeights[i];

        prefix_sum[i] = current_height * (i - prev_idx);
        if (prev_idx != -1) {
            prefix_sum[i] += prefix_sum[prev_idx];
        }
        stack_push(&s, i);
    }
    stack_free(&s);

    stack_init(&s, n);

    for (int i = n - 1; i >= 0; --i) {
        while (!stack_is_empty(&s) && maxHeights[stack_peek(&s)] > maxHeights[i]) {
            stack_pop(&s);
        }
        int next_idx = stack_is_empty(&s) ? n : stack_peek(&s);
        long long current_height = maxHeights[i];

        suffix_sum[i] = current_height * (next_idx - i);
        if (next_idx != n) {
            suffix_sum[i] += suffix_sum[next_idx];
        }
        stack_push(&s, i);
    }
    stack_free(&s);

    long long max_total_sum = 0;
    for (int i = 0; i < n; ++i) {
        max_total_sum = max(max_total_sum, prefix_sum[i] + suffix_sum[i] - maxHeights[i]);
    }

    free(prefix_sum);
    free(suffix_sum);

    return max_total_sum;
}