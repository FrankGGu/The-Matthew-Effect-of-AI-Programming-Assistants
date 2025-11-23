#include <stdio.h>
#include <stdlib.h>

struct Deque {
    int *data;
    int front, rear, size, capacity;
};

struct Deque* createDeque(int capacity) {
    struct Deque* deque = (struct Deque*)malloc(sizeof(struct Deque));
    deque->capacity = capacity;
    deque->front = deque->rear = -1;
    deque->size = 0;
    deque->data = (int*)malloc(capacity * sizeof(int));
    return deque;
}

int isEmpty(struct Deque* deque) {
    return deque->size == 0;
}

void insertRear(struct Deque* deque, int value) {
    if (deque->size == deque->capacity) return;
    if (deque->rear == deque->capacity - 1) deque->rear = -1;
    deque->data[++deque->rear] = value;
    deque->size++;
}

void removeFront(struct Deque* deque) {
    if (isEmpty(deque)) return;
    if (deque->front == deque->capacity - 1) deque->front = -1;
    deque->front++;
    deque->size--;
}

int getFront(struct Deque* deque) {
    return deque->data[(deque->front + 1) % deque->capacity];
}

void removeSmaller(struct Deque* deque, int value) {
    while (!isEmpty(deque) && getFront(deque) < value) {
        removeFront(deque);
    }
}

int* maxSlidingWindow(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    struct Deque* deque = createDeque(numsSize);

    for (int i = 0; i < numsSize; i++) {
        if (i >= k) {
            result[i - k] = getFront(deque);
            if (nums[i - k] == getFront(deque)) removeFront(deque);
        }
        removeSmaller(deque, nums[i]);
        insertRear(deque, nums[i]);
    }

    result[*returnSize - 1] = getFront(deque);
    free(deque->data);
    free(deque);
    return result;
}