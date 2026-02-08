#include <stdlib.h>
#include <limits.h> // For LLONG_MIN

typedef struct {
    int index;
    long long value;
} StackElement;

typedef struct {
    StackElement* data;
    int top;
    int capacity;
} Stack;

void initStack(Stack* s, int capacity) {
    s->data = (StackElement*)malloc(sizeof(StackElement) * capacity);
    s->top = -1;
    s->capacity = capacity;
}

int isEmpty(Stack* s) {
    return s->top == -1;
}

void push(Stack* s, int index, long long value) {
    // In a LeetCode context, capacity is usually sufficient.
    // Real-world code would include realloc or error handling.
    s->data[++(s->top)].index = index;
    s->data[s->top].value = value;
}

StackElement pop(Stack* s) {
    // In a LeetCode context, stack underflow is typically avoided by problem constraints.
    return s->data[(s->top)--];
}

StackElement peek(Stack* s) {
    return s->data[s->top];
}

void freeStack(Stack* s) {
    free(s->data);
    s->data = NULL;
}

long long maximumSumOfHeights(int* maxHeights, int maxHeightsSize) {
    int n = maxHeightsSize;
    long long* left_dp = (long long*)malloc(sizeof(long long) * n);
    long long* right_dp = (long long*)malloc(sizeof(long long) * n);

    // Calculate left_dp
    // left_dp[i] = sum_{j=0 to i} h_j where h_j = min_{k=j to i} (maxHeights[k] + k) - j
    // This is sum_{j=0 to i} (min_{k=j to i} (maxHeights[k] + k)) - sum_{j=0 to i} j
    // The first part is calculated using a monotonic stack.
    Stack st_left;
    initStack(&st_left, n);
    long long current_sum_min_f = 0; // Represents sum_{j=0 to i} (min_{k=j to i} (maxHeights[k] + k))
    for (int i = 0; i < n; ++i) {
        long long f_i = (long long)maxHeights[i] + i;
        int segment_start_idx = i; // Leftmost index that f_i is the minimum for, in the current context
        while (!isEmpty(&st_left) && peek(&st_left).value >= f_i) {
            StackElement prev = pop(&st_left);
            // Remove contribution of prev_val from current_sum_min_f
            // prev_val was the minimum for segment [prev.index, segment_start_idx - 1]
            current_sum_min_f -= prev.value * (segment_start_idx - prev.index);
            segment_start_idx = prev.index; // Update segment_start_idx to the leftmost index of the popped segment
        }
        // Add contribution of f_i to current_sum_min_f
        // f_i is the minimum for segment [segment_start_idx, i]
        current_sum_min_f += f_i * (i - segment_start_idx + 1);
        push(&st_left, segment_start_idx, f_i);
        left_dp[i] = current_sum_min_f - (long long)i * (i + 1) / 2;
    }
    freeStack(&st_left);

    // Calculate right_dp
    // right_dp[i] = sum_{j=i to n-1} h_j where h_j = min_{k=i to j} (maxHeights[k] - k) + j
    // This is sum_{j=i to n-1} (min_{k=i to j} (maxHeights[k] - k)) + sum_{j=i to n-1} j
    // The first part is calculated using a monotonic stack.
    Stack st_right;
    initStack(&st_right, n);
    long long current_sum_min_f_prime = 0; // Represents sum_{j=i to n-1} (min_{k=i to j} (maxHeights[k] - k))
    for (int i = n - 1; i >= 0; --i) {
        long long f_prime_i = (long long)maxHeights[i] - i;
        int segment_end_idx = i; // Rightmost index that f_prime_i is the minimum for, in the current context
        while (!isEmpty(&st_right) && peek(&st_right).value >= f_prime_i) {
            StackElement prev = pop(&st_right);
            // Remove contribution of prev_val from current_sum_min_f_prime
            // prev_val was the minimum for segment [segment_end_idx + 1, prev.index]
            current_sum_min_f_prime -= prev.value * (prev.index - segment_end_idx);
            segment_end_idx = prev.index; // Update segment_end_idx to the rightmost index of the popped segment
        }
        // Add contribution of f_prime_i to current_sum_min_f_prime
        // f_prime_i is the minimum for segment [i, segment_end_idx]
        current_sum_min_f_prime += f_prime_i * (segment_end_idx - i + 1);
        push(&st_right, segment_end_idx, f_prime_i);
        right_dp[i] = current_sum_min_f_prime + (long long)(n - i) * (i + n - 1) / 2;
    }
    freeStack(&st_right);

    long long max_total_height = 0;
    for (int i = 0; i < n; ++i) {
        long long current_total = left_dp[i] + right_dp[i] - maxHeights[i];
        if (current_total > max_total_height) {
            max_total_height = current_total;
        }
    }

    free(left_dp);
    free(right_dp);

    return max_total_height;
}