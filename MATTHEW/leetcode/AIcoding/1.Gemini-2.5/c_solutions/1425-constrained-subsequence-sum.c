#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

typedef struct {
    int* data;
    int head;
    int tail;
    int count;
    int capacity;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (int*)malloc(sizeof(int) * capacity);
    dq->head = 0;
    dq->tail = 0;
    dq->count = 0;
    dq->capacity = capacity;
    return dq;
}

bool isEmpty(Deque* dq) {
    return dq->count == 0;
}

void push_back(Deque* dq, int val) {
    dq->data[dq->tail] = val;
    dq->tail = (dq->tail + 1) % dq->capacity;
    dq->count++;
}

int pop_front(Deque* dq) {
    int val = dq->data[dq->head];
    dq->head = (dq->head + 1) % dq->capacity;
    dq->count--;
    return val;
}

int pop_back(Deque* dq) {
    dq->tail = (dq->tail - 1 + dq->capacity) % dq->capacity;
    int val = dq->data[dq->tail];
    dq->count--;
    return val;
}

int front(Deque* dq) {
    return dq->data[dq->head];
}

int back(Deque* dq) {
    return dq->data[(dq->tail - 1 + dq->capacity) % dq->capacity];
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int constrainedSubsetSum(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(sizeof(int) * numsSize);
    Deque* dq = createDeque(numsSize);

    int max_global_sum = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        while (!isEmpty(dq) && front(dq) < i - k) {
            pop_front(dq);
        }

        int prev_max_dp_val = 0;
        if (!isEmpty(dq)) {
            prev_max_dp_val = dp[front(dq)];
        }

        dp[i] = nums[i] + max(0, prev_max_dp_val);

        max_global_sum = max(max_global_sum, dp[i]);

        while (!isEmpty(dq) && dp[back(dq)] <= dp[i]) {
            pop_back(dq);
        }
        push_back(dq, i);
    }

    freeDeque(dq);
    free(dp);

    return max_global_sum;
}