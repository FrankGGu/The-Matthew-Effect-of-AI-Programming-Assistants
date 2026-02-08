#include <stdio.h>
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
    dq->data = (int*)malloc(capacity * sizeof(int));
    dq->front = 0;
    dq->rear = -1;
    dq->size = 0;
    dq->capacity = capacity;
    return dq;
}

void pushFront(Deque* dq, int value) {
    if (dq->size == dq->capacity) return;
    dq->rear = (dq->rear + 1) % dq->capacity;
    dq->data[dq->rear] = value;
    dq->size++;
}

void popFront(Deque* dq) {
    if (dq->size == 0) return;
    dq->front = (dq->front + 1) % dq->capacity;
    dq->size--;
}

void pushBack(Deque* dq, int value) {
    if (dq->size == dq->capacity) return;
    dq->front = (dq->front - 1 + dq->capacity) % dq->capacity;
    dq->data[dq->front] = value;
    dq->size++;
}

void popBack(Deque* dq) {
    if (dq->size == 0) return;
    dq->front = (dq->front + 1) % dq->capacity;
    dq->size--;
}

int getFront(Deque* dq) {
    return dq->data[dq->front];
}

int getBack(Deque* dq) {
    return dq->data[dq->rear];
}

int isEmpty(Deque* dq) {
    return dq->size == 0;
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

int longestSubarray(int* nums, int numsSize, int limit) {
    Deque* maxDeque = createDeque(numsSize);
    Deque* minDeque = createDeque(numsSize);
    int left = 0;
    int result = 0;

    for (int right = 0; right < numsSize; right++) {
        while (!isEmpty(maxDeque) && nums[right] > getBack(maxDeque)) {
            popBack(maxDeque);
        }
        pushBack(maxDeque, nums[right]);

        while (!isEmpty(minDeque) && nums[right] < getBack(minDeque)) {
            popBack(minDeque);
        }
        pushBack(minDeque, nums[right]);

        while (getBack(maxDeque) - getFront(minDeque) > limit) {
            if (nums[left] == getFront(maxDeque)) {
                popFront(maxDeque);
            }
            if (nums[left] == getFront(minDeque)) {
                popFront(minDeque);
            }
            left++;
        }

        result = (right - left + 1) > result ? (right - left + 1) : result;
    }

    freeDeque(maxDeque);
    freeDeque(minDeque);
    return result;
}