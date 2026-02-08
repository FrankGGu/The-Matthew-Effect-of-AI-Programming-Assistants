#include <stdlib.h> // For malloc, free
#include <limits.h> // For LONG_MAX

typedef struct {
    long long* arr;
    int capacity;
    int size;
} MaxHeap;

void swap(long long* a, long long* b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void initMaxHeap(MaxHeap* h, int capacity) {
    h->arr = (long long*)malloc(sizeof(long long) * capacity);
    h->capacity = capacity;
    h->size = 0;
}

void heapifyUpMax(MaxHeap* h, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && h->arr[parent] < h->arr[index]) {
        swap(&h->arr[parent], &h->arr[index]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDownMax(MaxHeap* h, int index) {
    int left = 2 * index + 1;
    int right = 2 * index + 2;
    int largest = index;

    if (left < h->size && h->arr[left] > h->arr[largest]) {
        largest = left;
    }
    if (right < h->size && h->arr[right] > h->arr[largest]) {
        largest = right;
    }

    if (largest != index) {
        swap(&h->arr[index], &h->arr[largest]);
        heapifyDownMax(h, largest);
    }
}

void insertMaxHeap(MaxHeap* h, long long val) {
    h->arr[h->size] = val;
    h->size++;
    heapifyUpMax(h, h->size - 1);
}

long long extractMaxMaxHeap(MaxHeap* h) {
    long long root = h->arr[0];
    h->arr[0] = h->arr[h->size - 1];
    h->size--;
    heapifyDownMax(h, 0);
    return root;
}

typedef struct {
    long long* arr;
    int capacity;
    int size;
} MinHeap;

void initMinHeap(MinHeap* h, int capacity) {
    h->arr = (long long*)malloc(sizeof(long long) * capacity);
    h->capacity = capacity;
    h->size = 0;
}

void heapifyUpMin(MinHeap* h, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && h->arr[parent] > h->arr[index]) {
        swap(&h->arr[parent], &h->arr[index]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDownMin(MinHeap* h, int index) {
    int left = 2 * index + 1;
    int right = 2 * index + 2;
    int smallest = index;

    if (left < h->size && h->arr[left] < h->arr[smallest]) {
        smallest = left;
    }
    if (right < h->size && h->arr[right] < h->arr[smallest]) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&h->arr[index], &h->arr[smallest]);
        heapifyDownMin(h, smallest);
    }
}

void insertMinHeap(MinHeap* h, long long val) {
    h->arr[h->size] = val;
    h->size++;
    heapifyUpMin(h, h->size - 1);
}

long long extractMinMinHeap(MinHeap* h) {
    long long root = h->arr[0];
    h->arr[0] = h->arr[h->size - 1];
    h->size--;
    heapifyDownMin(h, 0);
    return root;
}

long long minimumDifference(int* nums, int numsSize) {
    int n = numsSize / 3;

    long long* min_sum_prefix = (long long*)malloc(sizeof(long long) * (2 * n));
    long long* max_sum_suffix = (long long*)malloc(sizeof(long long) * (2 * n)); 

    // Calculate min_sum_prefix
    // pq_left is a Max-Heap to keep track of the n smallest elements
    MaxHeap pq_left; 
    initMaxHeap(&pq_left, n + 1); 
    long long current_sum_left = 0;

    for (int i = 0; i < 2 * n; ++i) {
        insertMaxHeap(&pq_left, nums[i]);
        current_sum_left += nums[i];
        if (pq_left.size > n) {
            current_sum_left -= extractMaxMaxHeap(&pq_left);
        }
        if (pq_left.size == n) {
            min_sum_prefix[i] = current_sum_left;
        } else {
            min_sum_prefix[i] = LONG_MAX; 
        }
    }

    // Calculate max_sum_suffix
    // pq_right is a Min-Heap to keep track of the n largest elements
    MinHeap pq_right; 
    initMinHeap(&pq_right, n + 1); 
    long long current_sum_right = 0;

    // Iterate from right to left, starting from index 3n-1 down to n
    // max_sum_suffix[k] corresponds to original index n+k
    for (int i = numsSize - 1; i >= n; --i) {
        insertMinHeap(&pq_right, nums[i]);
        current_sum_right += nums[i];
        if (pq_right.size > n) {
            current_sum_right -= extractMinMinHeap(&pq_right);
        }
        if (pq_right.size == n) {
            max_sum_suffix[i - n] = current_sum_right; 
        } else {
            max_sum_suffix[i - n] = LONG_MAX;
        }
    }

    long long min_diff = LONG_MAX;

    // Iterate through all possible split points
    // 'i' is the last index of the elements considered for the first sum.
    // The first sum elements are chosen from nums[0...i].
    // The second sum elements are chosen from nums[i+1...3n-1].
    // 'i' ranges from n-1 to 2n-1.
    for (int i = n - 1; i < 2 * n; ++i) {
        if (min_sum_prefix[i] != LONG_MAX && max_sum_suffix[i + 1 - n] != LONG_MAX) {
            long long diff = min_sum_prefix[i] - max_sum_suffix[i + 1 - n];
            if (diff < min_diff) {
                min_diff = diff;
            }
        }
    }

    free(pq_left.arr);
    free(pq_right.arr);
    free(min_sum_prefix);
    free(max_sum_suffix);

    return min_diff;
}