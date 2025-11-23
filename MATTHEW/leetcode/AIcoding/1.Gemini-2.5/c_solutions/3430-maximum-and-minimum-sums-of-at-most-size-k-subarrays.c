#include <stdlib.h>
#include <limits.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

typedef struct {
    int* data;
    int front;
    int rear;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (int*)malloc(sizeof(int) * capacity);
    dq->front = 0;
    dq->rear = 0;
    return dq;
}

int isEmpty(Deque* dq) {
    return dq->front == dq->rear;
}

void pushBack(Deque* dq, int val) {
    dq->data[dq->rear] = val;
    dq->rear++;
}

void popBack(Deque* dq) {
    dq->rear--;
}

void popFront(Deque* dq) {
    dq->front++;
}

int getFront(Deque* dq) {
    return dq->data[dq->front];
}

int getBack(Deque* dq) {
    return dq->data[dq->rear - 1];
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

long long* maximumAndMinimumSum(int* nums, int numsSize, int k, int* returnSize) {
    long long* result = (long long*)malloc(sizeof(long long) * 2);
    *returnSize = 2;

    long long* prefixSum = (long long*)malloc(sizeof(long long) * (numsSize + 1));
    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum[i+1] = prefixSum[i] + nums[i];
    }

    long long maxSum = LLONG_MIN;
    long long minSum = LLONG_MAX;

    Deque* dq_max = createDeque(numsSize + 1);
    Deque* dq_min = createDeque(numsSize + 1);

    pushBack(dq_max, 0);
    pushBack(dq_min, 0);

    for (int i = 1; i <= numsSize; i++) {
        while (!isEmpty(dq_max) && getFront(dq_max) < i - k) {
            popFront(dq_max);
        }
        maxSum = max(maxSum, prefixSum[i] - prefixSum[getFront(dq_max)]);
        while (!isEmpty(dq_max) && prefixSum[getBack(dq_max)] >= prefixSum[i]) {
            popBack(dq_max);
        }
        pushBack(dq_max, i);

        while (!isEmpty(dq_min) && getFront(dq_min) < i - k) {
            popFront(dq_min);
        }
        minSum = min(minSum, prefixSum[i] - prefixSum[getFront(dq_min)]);
        while (!isEmpty(dq_min) && prefixSum[getBack(dq_min)] <= prefixSum[i]) {
            popBack(dq_min);
        }
        pushBack(dq_min, i);
    }

    result[0] = maxSum;
    result[1] = minSum;

    free(prefixSum);
    freeDeque(dq_max);
    freeDeque(dq_min);

    return result;
}