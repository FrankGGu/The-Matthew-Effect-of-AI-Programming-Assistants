#include <limits.h>
#include <stdlib.h>

typedef struct {
    int val;
    int list_idx;
    int elem_idx;
} HeapNode;

HeapNode* heap_arr;
int heap_size_var;
int heap_capacity_var;

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heap_init(int capacity) {
    heap_capacity_var = capacity;
    heap_arr = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap_size_var = 0;
}

void heap_destroy() {
    free(heap_arr);
    heap_arr = NULL;
    heap_size_var = 0;
    heap_capacity_var = 0;
}

void heap_push(HeapNode node) {
    if (heap_size_var == heap_capacity_var) {
        // Should not happen as capacity is fixed to k (numsSize)
        return;
    }
    heap_arr[heap_size_var] = node;
    int current = heap_size_var;
    heap_size_var++;

    // Percolate up
    while (current > 0 && heap_arr[current].val < heap_arr[(current - 1) / 2].val) {
        swap(&heap_arr[current], &heap_arr[(current - 1) / 2]);
        current = (current - 1) / 2;
    }
}

HeapNode heap_pop() {
    if (heap_size_var == 0) {
        // Return a dummy node if heap is empty (should not be called in main logic)
        HeapNode dummy = {INT_MAX, -1, -1};
        return dummy;
    }

    HeapNode root = heap_arr[0];
    heap_size_var--;
    if (heap_size_var > 0) {
        heap_arr[0] = heap_arr[heap_size_var];
        int current = 0;
        // Percolate down
        while (1) {
            int left_child = 2 * current + 1;
            int right_child = 2 * current + 2;
            int smallest = current;

            if (left_child < heap_size_var && heap_arr[left_child].val < heap_arr[smallest].val) {
                smallest = left_child;
            }
            if (right_child < heap_size_var && heap_arr[right_child].val < heap_arr[smallest].val) {
                smallest = right_child;
            }

            if (smallest != current) {
                swap(&heap_arr[current], &heap_arr[smallest]);
                current = smallest;
            } else {
                break;
            }
        }
    }
    return root;
}

HeapNode heap_peek() {
    if (heap_size_var == 0) {
        HeapNode dummy = {INT_MAX, -1, -1}; // Should not happen in main loop
        return dummy;
    }
    return heap_arr[0];
}

int* smallestRange(int*** nums, int numsSize, int* numsColSize, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(sizeof(int) * 2);

    if (numsSize == 0) {
        result[0] = 0;
        result[1] = 0;
        return result;
    }

    heap_init(numsSize); // Initialize heap with capacity equal to k (numsSize)

    int max_val = INT_MIN; // Stores the maximum value currently in the heap

    // Initialize the heap with the first element from each list
    for (int i = 0; i < numsSize; i++) {
        // numsColSize[i] is guaranteed to be > 0 by constraints
        // Access element: nums[list_idx][0][element_idx]
        HeapNode node = {nums[i][0][0], i, 0};
        heap_push(node);
        if (nums[i][0][0] > max_val) {
            max_val = nums[i][0][0];
        }
    }

    int min_range_diff = INT_MAX; // Stores the minimum range difference found so far
    int range_start = 0;          // Stores the start of the smallest range
    int range_end = 0;            // Stores the end of the smallest range

    // Continue as long as the heap contains elements from all k lists
    while (heap_size_var == numsSize) {
        HeapNode min_node = heap_peek(); // Get the smallest element in the current window
        int current_min_val = min_node.val;

        // Calculate the current range difference
        int current_diff = max_val - current_min_val;

        // Check if the current range is smaller or lexicographically preferred
        if (current_diff < min_range_diff) {
            min_range_diff = current_diff;
            range_start = current_min_val;
            range_end = max_val;
        } else if (current_diff == min_range_diff) {
            // If range differences are equal, choose the one with the smaller start value
            if (current_min_val < range_start) {
                range_start = current_min_val;
                range_end = max_val;
            }
        }

        // Pop the smallest element from the heap
        heap_pop();

        // Try to add the next element from the same list
        int list_idx = min_node.list_idx;
        int elem_idx = min_node.elem_idx;

        if (elem_idx + 1 < numsColSize[list_idx]) {
            // If there's a next element in this list, add it to the heap
            HeapNode next_node = {nums[list_idx][0][elem_idx + 1], list_idx, elem_idx + 1};
            heap_push(next_node);
            // Update max_val if the new element is larger
            if (next_node.val > max_val) {
                max_val = next_node.val;
            }
        } else {
            // If this list is exhausted, we can no longer cover all k lists.
            // The loop condition (heap_size_var == numsSize) will become false, terminating the loop.
            break;
        }
    }

    result[0] = range_start;
    result[1] = range_end;

    heap_destroy(); // Clean up heap memory

    return result;
}