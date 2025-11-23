typedef struct {
    int value;
    int index;
} Node;

typedef struct {
    Node* data;
    int size;
    int capacity;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (Node*)malloc(sizeof(Node) * capacity);
    dq->size = 0;
    dq->capacity = capacity;
    return dq;
}

void pushBack(Deque* dq, int value, int index) {
    while (dq->size > 0 && dq->data[dq->size - 1].value <= value) {
        dq->size--;
    }
    dq->data[dq->size].value = value;
    dq->data[dq->size].index = index;
    dq->size++;
}

void pushFront(Deque* dq, int value, int index) {
    while (dq->size > 0 && dq->data[dq->size - 1].value >= value) {
        dq->size--;
    }
    dq->data[dq->size].value = value;
    dq->data[dq->size].index = index;
    dq->size++;
}

void popFront(Deque* dq, int index) {
    if (dq->size > 0 && dq->data[0].index == index) {
        for (int i = 0; i < dq->size - 1; i++) {
            dq->data[i] = dq->data[i + 1];
        }
        dq->size--;
    }
}

void popBack(Deque* dq, int index) {
    if (dq->size > 0 && dq->data[0].index == index) {
        for (int i = 0; i < dq->size - 1; i++) {
            dq->data[i] = dq->data[i + 1];
        }
        dq->size--;
    }
}

int front(Deque* dq) {
    return dq->data[0].value;
}

int back(Deque* dq) {
    return dq->data[0].value;
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

long long continuousSubarrays(int* nums, int numsSize) {
    Deque* maxDq = createDeque(numsSize);
    Deque* minDq = createDeque(numsSize);
    long long result = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        pushBack(maxDq, nums[right], right);
        pushFront(minDq, nums[right], right);

        while (front(maxDq) - back(minDq) > 2) {
            popFront(maxDq, left);
            popBack(minDq, left);
            left++;
        }

        result += (right - left + 1);
    }

    freeDeque(maxDq);
    freeDeque(minDq);
    return result;
}