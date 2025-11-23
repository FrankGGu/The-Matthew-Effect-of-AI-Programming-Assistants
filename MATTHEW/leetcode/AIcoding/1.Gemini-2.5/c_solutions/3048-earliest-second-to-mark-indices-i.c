#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    long long* data;
    int size;
    int capacity;
} MaxPQ;

void pq_init(MaxPQ* pq, int capacity) {
    pq->data = (long long*)malloc(sizeof(long long) * capacity);
    pq->size = 0;
    pq->capacity = capacity;
}

void pq_destroy(MaxPQ* pq) {
    free(pq->data);
}

void pq_swap(long long* a, long long* b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void pq_heapify_up(MaxPQ* pq, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && pq->data[index] > pq->data[parent]) {
        pq_swap(&pq->data[index], &pq->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void pq_heapify_down(MaxPQ* pq, int index) {
    int left_child = 2 * index + 1;
    int right_child = 2 * index + 2;
    int largest = index;

    if (left_child < pq->size && pq->data[left_child] > pq->data[largest]) {
        largest = left_child;
    }
    if (right_child < pq->size && pq->data[right_child] > pq->data[largest]) {
        largest = right_child;
    }

    if (largest != index) {
        pq_swap(&pq->data[index], &pq->data[largest]);
        pq_heapify_down(pq, largest);
    }
}

void pq_push(MaxPQ* pq, long long value) {
    if (pq->size == pq->capacity) {
        // This case should ideally not be hit if capacity is n and we only push n elements.
        // For robustness, one might realloc, but for competitive programming,
        // assuming sufficient initial capacity (n) is common.
        return; 
    }
    pq->data[pq->size] = value;
    pq_heapify_up(pq, pq->size);
    pq->size++;
}

long long pq_top(MaxPQ* pq) {
    if (pq->size == 0) {
        return -1; // Should not be called on empty PQ if logic is correct
    }
    return pq->data[0];
}

void pq_pop(MaxPQ* pq) {
    if (pq->size == 0) {
        return;
    }
    pq->data[0] = pq->data[pq->size - 1];
    pq->size--;
    pq_heapify_down(pq, 0);
}

bool pq_is_empty(MaxPQ* pq) {
    return pq->size == 0;
}

bool check(int t, int n, const int* nums, const int* changeIndices) {
    if (n == 0) return true; // No indices to mark

    int* last_occurrence = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; ++i) {
        last_occurrence[i] = -1;
    }

    // Find the last occurrence for each index within seconds [0, t-1]
    for (int s = 0; s < t; ++s) {
        int idx = changeIndices[s] - 1; // changeIndices is 1-indexed
        if (idx >= 0 && idx < n) {
            last_occurrence[idx] = s;
        }
    }

    // Check if all indices have at least one opportunity to be marked by second t
    for (int i = 0; i < n; ++i) {
        if (last_occurrence[i] == -1) {
            free(last_occurrence);
            return false;
        }
    }

    MaxPQ pq;
    // Max capacity for PQ is n (since we push at most one nums[i] for each index)
    pq_init(&pq, n);

    long long marked_count = 0;
    long long decrement_budget = 0; // This accumulates total decrements we can perform

    // Iterate through seconds from 0 to t-1
    for (int s = 0; s < t; ++s) {
        int idx = changeIndices[s] - 1;

        // If this is the last chance to mark 'idx' within 't' seconds
        if (s == last_occurrence[idx]) {
            pq_push(&pq, (long long)nums[idx]);
        }

        // At each second 's', we always get 1 unit of decrement budget.
        // This is because marking an index (when its nums[i] is 0) takes 0 seconds,
        // leaving the current second 's' free to be used for decrementing.
        // If we don't mark, it's also used for decrementing.
        decrement_budget++;

        // If there are indices to mark and we have enough budget for the most expensive one
        if (!pq_is_empty(&pq) && decrement_budget >= pq_top(&pq)) {
            decrement_budget -= pq_top(&pq);
            pq_pop(&pq);
            marked_count++;
        }
    }

    pq_destroy(&pq);
    free(last_occurrence);
    return marked_count == n;
}

int earliestSecondToMarkIndices(int* nums, int numsSize, int* changeIndices, int changeIndicesSize) {
    int n = numsSize;
    int m = changeIndicesSize;

    // Binary search for the earliest second t
    int low = 1;
    int high = m;
    int ans = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, n, nums, changeIndices)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}