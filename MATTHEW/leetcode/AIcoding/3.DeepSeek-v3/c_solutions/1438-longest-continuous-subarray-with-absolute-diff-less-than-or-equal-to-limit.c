typedef struct {
    int *data;
    int front;
    int rear;
    int size;
} Deque;

Deque* createDeque(int capacity) {
    Deque *dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (int*)malloc(capacity * sizeof(int));
    dq->front = 0;
    dq->rear = -1;
    dq->size = 0;
    return dq;
}

void pushBack(Deque *dq, int value) {
    dq->data[++dq->rear] = value;
    dq->size++;
}

void popBack(Deque *dq) {
    dq->rear--;
    dq->size--;
}

void popFront(Deque *dq) {
    dq->front++;
    dq->size--;
}

int back(Deque *dq) {
    return dq->data[dq->rear];
}

int front(Deque *dq) {
    return dq->data[dq->front];
}

void freeDeque(Deque *dq) {
    free(dq->data);
    free(dq);
}

int longestSubarray(int* nums, int numsSize, int limit) {
    Deque *maxDeque = createDeque(numsSize);
    Deque *minDeque = createDeque(numsSize);
    int left = 0, right = 0;
    int maxLength = 0;

    while (right < numsSize) {
        while (maxDeque->size > 0 && nums[right] > back(maxDeque)) {
            popBack(maxDeque);
        }
        while (minDeque->size > 0 && nums[right] < back(minDeque)) {
            popBack(minDeque);
        }
        pushBack(maxDeque, nums[right]);
        pushBack(minDeque, nums[right]);

        while (front(maxDeque) - front(minDeque) > limit) {
            if (nums[left] == front(maxDeque)) {
                popFront(maxDeque);
            }
            if (nums[left] == front(minDeque)) {
                popFront(minDeque);
            }
            left++;
        }

        maxLength = fmax(maxLength, right - left + 1);
        right++;
    }

    freeDeque(maxDeque);
    freeDeque(minDeque);
    return maxLength;
}