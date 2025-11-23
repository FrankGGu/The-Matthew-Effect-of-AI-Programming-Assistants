#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool

typedef struct {
    long long score;
    int index;
} DequeNode;

DequeNode* deque_arr;
int deque_front_idx;
int deque_rear_idx;
int deque_size;
int deque_capacity;

void deque_init(int capacity) {
    deque_capacity = capacity;
    deque_arr = (DequeNode*)malloc(sizeof(DequeNode) * capacity);
    deque_front_idx = 0;
    deque_rear_idx = -1; // Indicates empty
    deque_size = 0;
}

void deque_destroy() {
    free(deque_arr);
}

bool deque_is_empty() {
    return deque_size == 0;
}

void deque_push_back(long long score, int index) {
    // In a real-world scenario, you'd reallocate if deque_size == deque_capacity.
    // For competitive programming, capacity is often chosen as N, which is sufficient.
    deque_rear_idx = (deque_rear_idx + 1) % deque_capacity;
    deque_arr[deque_rear_idx].score = score;
    deque_arr[deque_rear_idx].index = index;
    deque_size++;
}

void deque_pop_front() {
    if (deque_is_empty()) return;
    deque_front_idx = (deque_front_idx + 1) % deque_capacity;
    deque_size--;
    if (deque_is_empty()) { // Reset indices if empty
        deque_front_idx = 0;
        deque_rear_idx = -1;
    }
}

void deque_pop_back() {
    if (deque_is_empty()) return;
    deque_rear_idx = (deque_rear_idx - 1 + deque_capacity) % deque_capacity;
    deque_size--;
    if (deque_is_empty()) { // Reset indices if empty
        deque_front_idx = 0;
        deque_rear_idx = -1;
    }
}

DequeNode deque_front() {
    return deque_arr[deque_front_idx];
}

DequeNode deque_back() {
    return deque_arr[deque_rear_idx];
}

long long maxResult(int* nums, int numsSize, int k) {
    long long* dp = (long long*)malloc(sizeof(long long) * numsSize);
    if (!dp) return 0;

    deque_init(numsSize);

    dp[0] = nums[0];
    deque_push_back(dp[0], 0);

    for (int i = 1; i < numsSize; i++) {
        while (!deque_is_empty() && deque_front().index < i - k) {
            deque_pop_front();
        }

        long long max_prev_score = deque_front().score;
        dp[i] = nums[i] + max_prev_score;

        while (!deque_is_empty() && deque_back().score <= dp[i]) {
            deque_pop_back();
        }
        deque_push_back(dp[i], i);
    }

    long long result = dp[numsSize - 1];

    free(dp);
    deque_destroy();

    return result;
}