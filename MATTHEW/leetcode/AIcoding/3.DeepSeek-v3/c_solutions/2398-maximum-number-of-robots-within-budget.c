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
    while (dq->size > 0 && dq->data[dq->rear] < val) {
        dq->rear--;
        dq->size--;
    }
    dq->data[++dq->rear] = val;
    dq->size++;
}

void popFront(Deque* dq, int val) {
    if (dq->size > 0 && dq->data[dq->front] == val) {
        dq->front++;
        dq->size--;
    }
}

int front(Deque* dq) {
    return dq->data[dq->front];
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

int maximumRobots(int* chargeTimes, int chargeTimesSize, int* runningCosts, int runningCostsSize, long long budget) {
    int left = 0;
    long long sum = 0;
    int maxLen = 0;
    Deque* dq = createDeque(chargeTimesSize);

    for (int right = 0; right < chargeTimesSize; right++) {
        sum += runningCosts[right];
        pushBack(dq, chargeTimes[right]);

        while (left <= right && (long long)front(dq) + (right - left + 1) * sum > budget) {
            sum -= runningCosts[left];
            popFront(dq, chargeTimes[left]);
            left++;
        }

        if (right - left + 1 > maxLen) {
            maxLen = right - left + 1;
        }
    }

    freeDeque(dq);
    return maxLen;
}