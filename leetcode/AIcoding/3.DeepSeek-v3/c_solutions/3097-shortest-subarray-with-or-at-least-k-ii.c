typedef struct {
    int* data;
    int front;
    int rear;
    int size;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (int*)malloc(capacity * sizeof(int));
    dq->front = 0;
    dq->rear = -1;
    dq->size = 0;
    return dq;
}

void pushBack(Deque* dq, int val) {
    dq->data[++dq->rear] = val;
    dq->size++;
}

void popBack(Deque* dq) {
    dq->rear--;
    dq->size--;
}

void popFront(Deque* dq) {
    dq->front++;
    dq->size--;
}

int back(Deque* dq) {
    return dq->data[dq->rear];
}

int front(Deque* dq) {
    return dq->data[dq->front];
}

int empty(Deque* dq) {
    return dq->size == 0;
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

int minimumSubarrayLength(int* nums, int numsSize, int k) {
    int res = INT_MAX;
    int* bits = (int*)calloc(32, sizeof(int));
    Deque* dq = createDeque(numsSize);

    int currentOR = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        currentOR |= nums[right];
        pushBack(dq, right);

        for (int b = 0; b < 32; b++) {
            if (nums[right] & (1 << b)) {
                bits[b]++;
            }
        }

        while (left <= right && currentOR >= k) {
            res = (res < (right - left + 1)) ? res : (right - left + 1);

            int leftVal = nums[front(dq)];
            popFront(dq);

            for (int b = 0; b < 32; b++) {
                if (leftVal & (1 << b)) {
                    bits[b]--;
                    if (bits[b] == 0) {
                        currentOR &= ~(1 << b);
                    }
                }
            }
            left++;
        }
    }

    free(bits);
    freeDeque(dq);
    return res == INT_MAX ? -1 : res;
}