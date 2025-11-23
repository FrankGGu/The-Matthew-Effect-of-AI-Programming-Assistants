#include <stdlib.h>

typedef struct {
    int* data;
    int front;
    int rear;
    int size;
    int capacity;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (int*)malloc(sizeof(int) * capacity);
    dq->front = 0;
    dq->rear = 0;
    dq->size = 0;
    dq->capacity = capacity;
    return dq;
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

void push_back(Deque* dq, int val) {
    dq->data[dq->rear] = val;
    dq->rear = (dq->rear + 1) % dq->capacity;
    dq->size++;
}

int pop_front(Deque* dq) {
    int val = dq->data[dq->front];
    dq->front = (dq->front + 1) % dq->capacity;
    dq->size--;
    return val;
}

int pop_back(Deque* dq) {
    dq->rear = (dq->rear - 1 + dq->capacity) % dq->capacity;
    int val = dq->data[dq->rear];
    dq->size--;
    return val;
}

int front(Deque* dq) {
    return dq->data[dq->front];
}

int back(Deque* dq) {
    return dq->data[(dq->rear - 1 + dq->capacity) % dq->capacity];
}

int isEmpty(Deque* dq) {
    return dq->size == 0;
}

int maxResult(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(sizeof(int) * numsSize);

    Deque* dq = createDeque(numsSize);

    dp[0] = nums[0];
    push_back(dq, 0);

    for (int i = 1; i < numsSize; i++) {
        while (!isEmpty(dq) && front(dq) < i - k) {
            pop_front(dq);
        }

        dp[i] = nums[i] + dp[front(dq)];

        while (!isEmpty(dq) && dp[back(dq)] <= dp[i]) {
            pop_back(dq);
        }

        push_back(dq, i);
    }

    int result = dp[numsSize - 1];

    free(dp);
    freeDeque(dq);

    return result;
}