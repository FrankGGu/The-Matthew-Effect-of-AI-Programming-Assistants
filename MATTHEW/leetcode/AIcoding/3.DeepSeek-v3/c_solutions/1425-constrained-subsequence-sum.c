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

void popFront(Deque* dq) {
    dq->front++;
    dq->size--;
}

void popBack(Deque* dq) {
    dq->rear--;
    dq->size--;
}

int front(Deque* dq) {
    return dq->data[dq->front];
}

int back(Deque* dq) {
    return dq->data[dq->rear];
}

int constrainedSubsetSum(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    Deque* dq = createDeque(numsSize);
    int maxSum = nums[0];

    for (int i = 0; i < numsSize; i++) {
        if (dq->size > 0 && i - front(dq) > k) {
            popFront(dq);
        }

        dp[i] = nums[i];
        if (dq->size > 0) {
            dp[i] = fmax(dp[i], nums[i] + dp[front(dq)]);
        }

        while (dq->size > 0 && dp[back(dq)] <= dp[i]) {
            popBack(dq);
        }

        if (dp[i] > 0) {
            pushBack(dq, i);
        }

        maxSum = fmax(maxSum, dp[i]);
    }

    free(dp);
    free(dq->data);
    free(dq);
    return maxSum;
}