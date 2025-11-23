#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    int size;
    int* tree;
} FenwickTree;

FenwickTree* createFenwickTree(int size) {
    FenwickTree* ft = (FenwickTree*)malloc(sizeof(FenwickTree));
    ft->size = size;
    ft->tree = (int*)calloc(size + 1, sizeof(int)); // 1-indexed internally
    return ft;
}

void updateFenwickTree(FenwickTree* ft, int idx, int val) {
    idx++; // Convert to 1-indexed
    while (idx <= ft->size) {
        ft->tree[idx] += val;
        idx += idx & (-idx);
    }
}

int queryFenwickTree(FenwickTree* ft, int idx) {
    idx++; // Convert to 1-indexed
    int sum = 0;
    while (idx > 0) {
        sum += ft->tree[idx];
        idx -= idx & (-idx);
    }
    return sum;
}

void freeFenwickTree(FenwickTree* ft) {
    free(ft->tree);
    free(ft);
}

typedef struct QueueNode {
    int val;
    struct QueueNode* next;
} QueueNode;

typedef struct {
    QueueNode* front;
    QueueNode* rear;
    int size;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->front = NULL;
    q->rear = NULL;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int val) {
    QueueNode* newNode = (QueueNode*)malloc(sizeof(QueueNode));
    newNode->val = val;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = newNode;
        q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
    q->size++;
}

int dequeue(Queue* q) {
    if (q->front == NULL) return -1; // Should not happen in this problem context
    QueueNode* temp = q->front;
    int val = temp->val;
    q->front = q->front->next;
    if (q->front == NULL) {
        q->rear = NULL;
    }
    free(temp);
    q->size--;
    return val;
}

bool isQueueEmpty(Queue* q) {
    return q->front == NULL;
}

int peekQueue(Queue* q) {
    if (q->front == NULL) return -1; // Should not happen in this problem context
    return q->front->val;
}

void freeQueue(Queue* q) {
    while (!isQueueEmpty(q)) {
        dequeue(q);
    }
    free(q);
}

int findKthUnpickedOriginalIdx(FenwickTree* ft, int target_relative_pos) {
    int low = 0, high = ft->size - 1;
    int ans = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        // count_unpicked_up_to_mid: number of unpicked elements with original index <= mid
        // This is (mid + 1) - queryFenwickTree(ft, mid)
        int count_unpicked_up_to_mid = (mid + 1) - queryFenwickTree(ft, mid);

        if (count_unpicked_up_to_mid > target_relative_pos) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

char* minInteger(char* num, int k) {
    int n = strlen(num);
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    result[n] = '\0';

    Queue* pos[10];
    for (int i = 0; i < 10; i++) {
        pos[i] = createQueue();
    }

    for (int j = 0; j < n; j++) {
        enqueue(pos[num[j] - '0'], j);
    }

    FenwickTree* ft = createFenwickTree(n);

    for (int i = 0; i < n; i++) {
        bool found_digit_for_i = false;
        for (int d = 0; d < 10; d++) {
            if (!isQueueEmpty(pos[d])) {
                int original_idx = peekQueue(pos[d]);

                // picked_before: count of elements picked with original index < original_idx
                int picked_before = queryFenwickTree(ft, original_idx - 1);

                // current_relative_pos: current 0-indexed position of this digit among unpicked digits
                int current_relative_pos = original_idx - picked_before;

                // swaps_needed: number of swaps to bring this digit to result[i]
                long long swaps_needed = (long long)current_relative_pos - i;

                if (swaps_needed >= 0 && swaps_needed <= k) {
                    result[i] = d + '0';
                    k -= swaps_needed;
                    dequeue(pos[d]);
                    updateFenwickTree(ft, original_idx, 1); // Mark original_idx as picked
                    found_digit_for_i = true;
                    break; // Found the smallest digit for current position i
                }
            }
        }

        if (!found_digit_for_i) {
            // This case happens if k is exhausted or too small to move any digit to position i.
            // We must pick the digit that is currently at position i in the remaining sequence.
            // Find the original index of the i-th unpicked digit.
            int target_original_idx = findKthUnpickedOriginalIdx(ft, i);
            int digit_val = num[target_original_idx] - '0';

            result[i] = digit_val + '0';

            // Remove this digit from its queue. It must be the front of its queue.
            // Loop through queues to find and dequeue the specific original_idx.
            // This is inefficient, but occurs only when k is exhausted.
            // A better way is to ensure `peekQueue(pos[digit_val]) == target_original_idx`
            // and then `dequeue`. `findKthUnpickedOriginalIdx` guarantees picking the leftmost
            // valid digit, so it should be at the front of its queue.
            dequeue(pos[digit_val]);
            updateFenwickTree(ft, target_original_idx, 1); // Mark original_idx as picked
        }
    }

    for (int i = 0; i < 10; i++) {
        freeQueue(pos[i]);
    }
    freeFenwickTree(ft);

    return result;
}