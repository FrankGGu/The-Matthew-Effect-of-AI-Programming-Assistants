#include <stdlib.h>
#include <string.h>

typedef struct {
    int front;
    int rear;
    int size;
    int* data;
} Queue;

Queue* createQueue(int size) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->front = 0;
    q->rear = 0;
    q->size = size;
    q->data = (int*)malloc(size * sizeof(int));
    return q;
}

void enqueue(Queue* q, int val) {
    q->data[q->rear++] = val;
}

int dequeue(Queue* q) {
    return q->data[q->front++];
}

int isEmpty(Queue* q) {
    return q->front == q->rear;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int* minReverseOperations(int n, int p, int* banned, int bannedSize, int k, int* returnSize) {
    int* res = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        res[i] = -1;
    }

    int* isBanned = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < bannedSize; i++) {
        isBanned[banned[i]] = 1;
    }

    res[p] = 0;

    Queue* q = createQueue(n);
    enqueue(q, p);

    int* sets[2];
    sets[0] = (int*)malloc((n + 1) * sizeof(int));
    sets[1] = (int*)malloc((n + 1) * sizeof(int));
    int sizes[2] = {0, 0};

    for (int i = 0; i < n; i++) {
        if (i != p && !isBanned[i]) {
            sets[i % 2][sizes[i % 2]++] = i;
        }
    }

    int* next[2];
    next[0] = (int*)malloc((n + 1) * sizeof(int));
    next[1] = (int*)malloc((n + 1) * sizeof(int));

    while (!isEmpty(q)) {
        int curr = dequeue(q);
        int step = res[curr];

        int minIdx = k - 1 - curr;
        if (minIdx < 0) minIdx = curr - k + 1;
        int maxIdx = 2 * n - k - 1 - curr;
        if (maxIdx >= n) maxIdx = n - 1 - (curr - (n - k));

        int left = (minIdx > curr) ? minIdx : curr;
        left = (minIdx > left) ? minIdx : left;
        int right = (maxIdx < curr) ? maxIdx : curr;
        right = (maxIdx < right) ? maxIdx : right;

        int actualMin = (minIdx < left) ? minIdx : left;
        int actualMax = (maxIdx > right) ? maxIdx : right;

        actualMin = (actualMin < 0) ? 0 : actualMin;
        actualMax = (actualMax >= n) ? n - 1 : actualMax;

        int parity = (k % 2 == 0) ? (1 - curr % 2) : (curr % 2);

        int* set = sets[parity];
        int* nxt = next[parity];
        int size = sizes[parity];

        int newSize = 0;
        for (int i = 0; i < size; i++) {
            if (set[i] >= actualMin && set[i] <= actualMax) {
                res[set[i]] = step + 1;
                enqueue(q, set[i]);
            } else {
                nxt[newSize++] = set[i];
            }
        }

        memcpy(sets[parity], nxt, newSize * sizeof(int));
        sizes[parity] = newSize;
    }

    free(isBanned);
    freeQueue(q);
    free(sets[0]);
    free(sets[1]);
    free(next[0]);
    free(next[1]);

    *returnSize = n;
    return res;
}