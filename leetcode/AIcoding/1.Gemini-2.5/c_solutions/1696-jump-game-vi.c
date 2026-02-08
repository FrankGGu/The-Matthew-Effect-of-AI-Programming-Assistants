#include <stdlib.h>

typedef struct {
    int* data;
    int front;
    int rear;
    int capacity;
    int size;
} Deque;

Deque* createDeque(int capacity) {
    Deque* deque = (Deque*)malloc(sizeof(Deque));
    deque->data = (int*)malloc(sizeof(int) * capacity);
    deque->front = 0;
    deque->rear = -1;
    deque->capacity = capacity;
    deque->size = 0;
    return deque;
}

void freeDeque(Deque* deque) {
    free(deque->data);
    free(deque);
}

int isEmpty(Deque* deque) {
    return deque->size == 0;
}

void addRear(Deque* deque, int val) {
    deque->rear = (deque->rear + 1) % deque->capacity;
    deque->data[deque->rear] = val;
    deque->size++;
}

int removeFront(Deque* deque) {
    int val = deque->data[deque->front];
    deque->front = (deque->front + 1) % deque->capacity;
    deque->size--;
    return val;
}

int removeRear(Deque* deque) {
    int val = deque->data[deque->rear];
    deque->rear = (deque->rear - 1 + deque->capacity) % deque->capacity;
    deque->size--;
    return val;
}

int peekFront(Deque* deque) {
    return deque->data[deque->front];
}

int peekRear(Deque* deque) {
    return deque->data[deque->rear];
}

int maxResult(int* nums, int numsSize, int k) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    Deque* deque = createDeque(numsSize);

    addRear(deque, 0);

    for (int i = 1; i < numsSize; i++) {
        while (!isEmpty(deque) && peekFront(deque) < i - k) {
            removeFront(deque);
        }

        nums[i] = nums[i] + nums[peekFront(deque)];

        while (!isEmpty(deque) && nums[peekRear(deque)] <= nums[i]) {
            removeRear(deque);
        }

        addRear(deque, i);
    }

    int result = nums[numsSize - 1];
    freeDeque(deque);
    return result;
}