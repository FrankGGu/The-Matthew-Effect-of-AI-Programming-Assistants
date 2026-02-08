#include <stdlib.h> // For malloc, free

typedef struct {
    int* arr;
    int top;
    int capacity;
} Stack;

void initStack(Stack* s, int capacity) {
    s->arr = (int*)malloc(sizeof(int) * capacity);
    s->top = -1;
    s->capacity = capacity;
}

void freeStack(Stack* s) {
    free(s->arr);
}

void push(Stack* s, int val) {
    if (s->top < s->capacity - 1) {
        s->arr[++s->top] = val;
    }
}

int pop(Stack* s) {
    if (s->top != -1) {
        return s->arr[s->top--];
    }
    return -1; // Should not be reached with correct logic
}

int peek(Stack* s) {
    if (s->top != -1) {
        return s->arr[s->top];
    }
    return -1; // Should not be reached with correct logic
}

int isEmpty(Stack* s) {
    return s->top == -1;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int longestWellPerformingInterval(int* hours, int hoursSize) {
    int N = hoursSize;

    // P array to store prefix sums of scores
    // scores[k] = 1 if hours[k] > 8, else -1
    // P[0] = 0
    // P[k+1] = P[k] + scores[k]
    int P[N + 1]; 
    P[0] = 0;

    for (int k = 0; k < N; ++k) {
        P[k + 1] = P[k] + (hours[k] > 8 ? 1 : -1);
    }

    // Stack to store indices 'i' such that P[i] is strictly decreasing
    Stack s;
    initStack(&s, N + 1); // Max N+1 elements in P

    int max_len = 0;

    // First pass: Build the stack
    // The stack will contain indices `i_0, i_1, ..., i_m` such that
    // `i_0 < i_1 < ... < i_m` and `P[i_0] > P[i_1] > ... > P[i_m]`
    for (int j = 0; j <= N; ++j) {
        if (isEmpty(&s) || P[j] < P[peek(&s)]) {
            push(&s, j);
        }
    }

    // Second pass: Iterate from right to left to find the longest interval
    // For each `j` (current end index of prefix sum),
    // we want to find the smallest `i` (start index of prefix sum) in the stack
    // such that `P[j] > P[i]`.
    // The length of the interval is `j - i`.
    for (int j = N; j >= 0; --j) {
        // While the stack is not empty and P[j] is greater than P[stack.top()]
        // (meaning P[j] - P[stack.top()] > 0)
        while (!isEmpty(&s) && P[j] > P[peek(&s)]) {
            int i = pop(&s); // Pop the index 'i' from the stack
            max_len = max(max_len, j - i); // Update max_len with the current interval length
        }
    }

    freeStack(&s);
    return max_len;
}