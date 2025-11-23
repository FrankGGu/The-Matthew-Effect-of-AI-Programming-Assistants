#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memcpy (though not used in final logic)

typedef struct {
    long long val;
} HeapNode;

typedef struct {
    HeapNode* nodes;
    int capacity;
    int size;
} MaxHeap;

void max_heap_init(MaxHeap* heap, int capacity) {
    heap->nodes = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
}

void max_heap_destroy(MaxHeap* heap) {
    free(heap->nodes);
}

void max_heap_swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void max_heap_bubble_up(MaxHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->nodes[index].val > heap->nodes[parent].val) {
        max_heap_swap(&heap->nodes[index], &heap->nodes[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void max_heap_bubble_down(MaxHeap* heap, int index) {
    int left_child = 2 * index + 1;
    int right_child = 2 * index + 2;
    int largest = index;

    if (left_child < heap->size && heap->nodes[left_child].val > heap->nodes[largest].val) {
        largest = left_child;
    }
    if (right_child < heap->size && heap->nodes[right_child].val > heap->nodes[largest].val) {
        largest = right_child;
    }

    if (largest != index) {
        max_heap_swap(&heap->nodes[index], &heap->nodes[largest]);
        max_heap_bubble_down(heap, largest);
    }
}

void max_heap_push(MaxHeap* heap, long long val) {
    if (heap->size == heap->capacity) {
        // This should not happen if capacity is chosen correctly (e.g., n)
        // For LeetCode, usually N is small enough for fixed size or realloc.
        // Let's assume capacity is sufficient (N).
        return; 
    }
    heap->nodes[heap->size].val = val;
    heap->size++;
    max_heap_bubble_up(heap, heap->size - 1);
}

long long max_heap_pop(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1; // Indicate error or empty
    }
    long long val = heap->nodes[0].val;
    heap->nodes[0] = heap->nodes[heap->size - 1];
    heap->size--;
    max_heap_bubble_down(heap, 0);
    return val;
}

bool max_heap_is_empty(MaxHeap* heap) {
    return heap->size == 0;
}

bool check(long long T, int n, int* original_nums, int numsSize, int** changeIndices, int changeIndicesSize) {
    int* last_op_time = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; ++i) {
        last_op_time[i] = -1;
    }

    // Find the last occurrence of each index within [0, T-1] (0-indexed seconds)
    for (int s = 0; s < T; ++s) {
        if (s >= changeIndicesSize) break; // If T exceeds m (number of operations)
        last_op_time[changeIndices[s][0]] = s;
    }

    // Check if all indices have a last occurrence within time T
    for (int i = 0; i < n; ++i) {
        if (last_op_time[i] == -1) {
            free(last_op_time);
            return false;
        }
    }

    MaxHeap pq;
    max_heap_init(&pq, n); 
    long long free_slots = 0; // Represents available slots for decrements. Can be negative if we need to "borrow".
    int marked_count = 0;     // Number of indices we are committed to mark.

    for (int s = 0; s < T; ++s) { // s is 0-indexed, corresponds to second s+1
        if (s >= changeIndicesSize) { // No more operations in changeIndices array
            break;
        }

        int idx = changeIndices[s][0];

        if (s == last_op_time[idx]) {
            // This is the last chance to mark `idx`. We must mark it.
            // This costs 1 slot for marking, and `original_nums[idx]` slots for decrements.
            // We push `original_nums[idx]` to the priority queue.
            max_heap_push(&pq, original_nums[idx]);
            marked_count++;
            free_slots -= original_nums[idx]; // We need `original_nums[idx]` decrements.
        } else {
            // This second `s` is not the last chance for `idx`.
            // We can use it to decrement `nums[idx]`, or if `nums[idx]` is 0, it's a "free" slot.
            // This second `s` contributes 1 "free slot" for decrements.
            free_slots++;
        }

        // If `free_slots` is negative, it means we have committed to more decrements than we have free slots.
        // We need to "un-commit" the most expensive index from `pq` to free up slots.
        // The most expensive index is the one that required the most decrements (largest `val` in max-heap).
        while (free_slots < 0 && !max_heap_is_empty(&pq)) {
            long long val = max_heap_pop(&pq);
            // When we un-commit this index, its `val` decrements are no longer needed,
            // and its 1 mark slot is no longer needed. So, `val + 1` slots become free.
            free_slots += (val + 1); 
            marked_count--;
        }
    }

    bool result = (marked_count == n);
    max_heap_destroy(&pq);
    free(last_op_time);
    return result;
}

int earliestSecondToMarkIndices(int* nums, int numsSize, int** changeIndices, int changeIndicesSize, int* changeIndicesColSize) {
    int n = numsSize;
    int m = changeIndicesSize;

    long long low = n; // Minimum possible time is n (if all nums[i] are 0, we still need n marks)
    long long high = m; // Maximum possible time is m (all available seconds)
    long long ans = -1;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (check(mid, n, nums, numsSize, changeIndices, changeIndicesSize)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return (int)ans;
}