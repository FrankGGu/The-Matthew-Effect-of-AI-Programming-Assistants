#include <stdlib.h>
#include <limits.h>

typedef struct {
    long long* data;
    int size;
    int capacity;
} MaxHeap;

void max_heap_init(MaxHeap* h, int capacity) {
    h->data = (long long*)malloc(sizeof(long long) * capacity);
    h->size = 0;
    h->capacity = capacity;
}

void max_heap_free(MaxHeap* h) {
    free(h->data);
}

void max_heap_push(MaxHeap* h, long long val) {
    h->data[h->size] = val;
    int current = h->size;
    h->size++;
    while (current > 0 && h->data[current] > h->data[(current - 1) / 2]) {
        long long temp = h->data[current];
        h->data[current] = h->data[(current - 1) / 2];
        h->data[(current - 1) / 2] = temp;
        current = (current - 1) / 2;
    }
}

long long max_heap_pop(MaxHeap* h) {
    long long root = h->data[0];
    h->size--;
    if (h->size > 0) {
        h->data[0] = h->data[h->size];
        int current = 0;
        while (1) {
            int left_child = 2 * current + 1;
            int right_child = 2 * current + 2;
            int largest = current;

            if (left_child < h->size && h->data[left_child] > h->data[largest]) {
                largest = left_child;
            }
            if (right_child < h->size && h->data[right_child] > h->data[largest]) {
                largest = right_child;
            }

            if (largest != current) {
                long long temp = h->data[current];
                h->data[current] = h->data[largest];
                h->data[largest] = temp;
                current = largest;
            } else {
                break;
            }
        }
    }
    return root;
}

long long max_heap_top(MaxHeap* h) {
    if (h->size == 0) return LLONG_MIN; // Sentinel for empty heap
    return h->data[0];
}

typedef struct {
    long long* data;
    int size;
    int capacity;
} MinHeap;

void min_heap_init(MinHeap* h, int capacity) {
    h->data = (long long*)malloc(sizeof(long long) * capacity);
    h->size = 0;
    h->capacity = capacity;
}

void min_heap_free(MinHeap* h) {
    free(h->data);
}

void min_heap_push(MinHeap* h, long long val) {
    h->data[h->size] = val;
    int current = h->size;
    h->size++;
    while (current > 0 && h->data[current] < h->data[(current - 1) / 2]) {
        long long temp = h->data[current];
        h->data[current] = h->data[(current - 1) / 2];
        h->data[(current - 1) / 2] = temp;
        current = (current - 1) / 2;
    }
}

long long min_heap_pop(MinHeap* h) {
    long long root = h->data[0];
    h->size--;
    if (h->size > 0) {
        h->data[0] = h->data[h->size];
        int current = 0;
        while (1) {
            int left_child = 2 * current + 1;
            int right_child = 2 * current + 2;
            int smallest = current;

            if (left_child < h->size && h->data[left_child] < h->data[smallest]) {
                smallest = left_child;
            }
            if (right_child < h->size && h->data[right_child] < h->data[smallest]) {
                smallest = right_child;
            }

            if (smallest != current) {
                long long temp = h->data[current];
                h->data[current] = h->data[smallest];
                h->data[smallest] = temp;
                current = smallest;
            } else {
                break;
            }
        }
    }
    return root;
}

long long min_heap_top(MinHeap* h) {
    if (h->size == 0) return LLONG_MAX; // Sentinel for empty heap
    return h->data[0];
}

MaxHeap left_heap_actual, left_heap_removed;
MinHeap right_heap_actual, right_heap_removed;

long long left_sum_actual = 0;
long long right_sum_actual = 0;

void clean_heaps() {
    while (left_heap_actual.size > 0 && left_heap_removed.size > 0 && max_heap_top(&left_heap_actual) == max_heap_top(&left_heap_removed)) {
        max_heap_pop(&left_heap_actual);
        max_heap_pop(&left_heap_removed);
    }
    while (right_heap_actual.size > 0 && right_heap_removed.size > 0 && min_heap_top(&right_heap_actual) == min_heap_top(&right_heap_removed)) {
        min_heap_pop(&right_heap_actual);
        min_heap_pop(&right_heap_removed);
    }
}

void balance_heaps() {
    clean_heaps(); // Always clean before balancing

    // Move elements from right to left if left is too small
    while (left_heap_actual.size < right_heap_actual.size) {
        long long val = min_heap_pop(&right_heap_actual);
        right_sum_actual -= val;
        max_heap_push(&left_heap_actual, val);
        left_sum_actual += val;
        clean_heaps(); // Clean after moving
    }
    // Move elements from left to right if left is too large
    while (left_heap_actual.size > right_heap_actual.size + 1) {
        long long val = max_heap_pop(&left_heap_actual);
        left_sum_actual -= val;
        min_heap_push(&right_heap_actual, val);
        right_sum_actual += val;
        clean_heaps(); // Clean after moving
    }
}

void add_val(long long val) {
    clean_heaps(); // Clean before deciding where to push

    if (left_heap_actual.size == 0 || val <= max_heap_top(&left_heap_actual)) {
        max_heap_push(&left_heap_actual, val);
        left_sum_actual += val;
    } else {
        min_heap_push(&right_heap_actual, val);
        right_sum_actual += val;
    }
    balance_heaps();
}

void remove_val(long long val) {
    clean_heaps(); // Clean before deciding where it was

    // Determine which heap 'val' would be in if it were still present
    // This assumes 'val' was in one of the actual heaps.
    if (val <= max_heap_top(&left_heap_actual)) { // It was in left_heap
        max_heap_push(&left_heap_removed, val);
        left_sum_actual -= val;
    } else { // It was in right_heap
        min_heap_push(&right_heap_removed, val);
        right_sum_actual -= val;
    }
    balance_heaps();
}

long long get_median() {
    clean_heaps(); // Ensure the top is valid
    return max_heap_top(&left_heap_actual);
}

long long minMoves(int* nums, int numsSize, int k) {
    // Step 1: Find all indices of '1's
    int* ones_indices = (int*)malloc(sizeof(int) * numsSize);
    int ones_count = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == 1) {
            ones_indices[ones_count++] = i;
        }
    }

    if (ones_count < k) {
        free(ones_indices);
        return 0; 
    }

    // Step 2: Create transformed_indices
    // transformed_indices[j] = ones_indices[j] - j
    // These are the values for which we want to find the median and sum of absolute differences
    long long* transformed_indices = (long long*)malloc(sizeof(long long) * ones_count);
    for (int i = 0; i < ones_count; ++i) {
        transformed_indices[i] = (long long)ones_indices[i] - i;
    }

    // Initialize heaps (capacity is 2 * ones_count to handle lazy deletion)
    int heap_capacity = 2 * ones_count + 5; 
    max_heap_init(&left_heap_actual, heap_capacity);
    max_heap_init(&left_heap_removed, heap_capacity);
    min_heap_init(&right_heap_actual, heap_capacity);
    min_heap_init(&right_heap_removed, heap_capacity);

    left_sum_actual = 0;
    right_sum_actual = 0;

    // Step 3: Populate initial window [0, k-1]
    for (int i = 0; i < k; ++i) {
        add_val(transformed_indices[i]);
    }

    long long min_total_swaps = LLONG_MAX;

    // Step 4: Calculate initial cost
    long long median = get_median();
    long long current_total_swaps;

    // The cost is sum(|x_i - M|) where M is the median.
    // This can be calculated as (sum of elements > M) - (sum of elements < M).
    // If k is odd, M is in left_heap_actual, so it's part of left_sum_actual.
    // Cost = right_sum_actual - (left_sum_actual - M) + (M - M) = right_sum_actual - left_sum_actual + M
    // If k is even, M is the largest in left_heap_actual.
    // Cost = right_sum_actual - left_sum_actual
    current_total_swaps = right_sum_actual - left_sum_actual + (k % 2 == 1 ? median : 0);
    min_total_swaps = current_total_swaps;

    // Step 5: Slide the window
    for (int i = 1; i <= ones_count - k; ++i) {
        remove_val(transformed_indices[i-1]);
        add_val(transformed_indices[i+k-1]);

        median = get_median();
        current_total_swaps = right_sum_actual - left_sum_actual + (k % 2 == 1 ? median : 0);
        if (current_total_swaps < min_total_swaps) {
            min_total_swaps = current_total_swaps;
        }
    }

    // Free allocated memory
    max_heap_free(&left_heap_actual);
    max_heap_free(&left_heap_removed);
    min_heap_free(&right_heap_actual);
    min_heap_free(&right_heap_removed);
    free(ones_indices);
    free(transformed_indices);

    return min_total_swaps;
}