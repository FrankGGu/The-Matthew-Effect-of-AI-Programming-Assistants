typedef struct {
    long long key;
    int count;
    UT_hash_handle hh;
} Counter;

typedef struct {
    long long* data;
    int front;
    int rear;
    int size;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->data = (long long*)malloc(capacity * sizeof(long long));
    dq->front = 0;
    dq->rear = -1;
    dq->size = 0;
    return dq;
}

void pushBack(Deque* dq, long long val) {
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

long long front(Deque* dq) {
    return dq->data[dq->front];
}

long long back(Deque* dq) {
    return dq->data[dq->rear];
}

int empty(Deque* dq) {
    return dq->size == 0;
}

void freeDeque(Deque* dq) {
    free(dq->data);
    free(dq);
}

int cmp(const void* a, const void* b) {
    return *(long long*)a - *(long long*)b;
}

long long* findXSum(int* nums, int numsSize, int k, int x, int* returnSize) {
    *returnSize = numsSize - k + 1;
    long long* res = (long long*)malloc(*returnSize * sizeof(long long));
    Counter* countMap = NULL;
    Deque* dq = createDeque(numsSize);

    long long sum = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        long long num = nums[right];
        Counter* entry;
        HASH_FIND_INT(countMap, &num, entry);
        if (entry == NULL) {
            entry = (Counter*)malloc(sizeof(Counter));
            entry->key = num;
            entry->count = 0;
            HASH_ADD_INT(countMap, key, entry);
        }
        entry->count++;

        while (!empty(dq) && back(dq) < num) {
            popBack(dq);
        }
        pushBack(dq, num);

        if (right - left + 1 > k) {
            long long leftNum = nums[left];
            Counter* leftEntry;
            HASH_FIND_INT(countMap, &leftNum, leftEntry);
            leftEntry->count--;
            if (leftEntry->count == 0) {
                HASH_DEL(countMap, leftEntry);
                free(leftEntry);
            }

            if (front(dq) == leftNum) {
                popFront(dq);
            }
            left++;
        }

        if (right - left + 1 == k) {
            long long temp[x];
            int idx = 0;
            Counter *curr, *tmp;
            HASH_ITER(hh, countMap, curr, tmp) {
                if (idx < x) {
                    temp[idx++] = curr->key * curr->count;
                } else {
                    if (curr->key * curr->count > temp[0]) {
                        temp[0] = curr->key * curr->count;
                        qsort(temp, x, sizeof(long long), cmp);
                    }
                }
            }
            while (idx < x) {
                temp[idx++] = 0;
            }
            qsort(temp, x, sizeof(long long), cmp);

            long long total = 0;
            for (int i = 0; i < x; i++) {
                total += temp[i];
            }
            res[right - k + 1] = total;
        }
    }

    Counter *curr, *tmp;
    HASH_ITER(hh, countMap, curr, tmp) {
        HASH_DEL(countMap, curr);
        free(curr);
    }
    freeDeque(dq);

    return res;
}