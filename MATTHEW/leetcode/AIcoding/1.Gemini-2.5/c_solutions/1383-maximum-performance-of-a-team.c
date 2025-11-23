#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int speed;
    int efficiency;
} Engineer;

int compareEngineers(const void *a, const void *b) {
    return ((Engineer*)b)->efficiency - ((Engineer*)a)->efficiency;
}

typedef struct {
    int* data;
    int capacity;
    int size;
} MinHeap;

MinHeap* heap_create(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index] < heap->data[parent]) {
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapify_down(MinHeap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left] < heap->data[smallest]) {
        smallest = left;
    }
    if (right < heap->size && heap->data[right] < heap->data[smallest]) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapify_down(heap, smallest);
    }
}

void heap_push(MinHeap* heap, int val) {
    heap->data[heap->size] = val;
    heap->size++;
    heapify_up(heap, heap->size - 1);
}

int heap_pop(MinHeap* heap) {
    if (heap->size == 0) {
        return -1; 
    }
    int root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    if (heap->size > 0) {
        heapify_down(heap, 0);
    }
    return root;
}

int heap_peek(MinHeap* heap) {
    if (heap->size == 0) {
        return -1; 
    }
    return heap->data[0];
}

void heap_destroy(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

long long maxPerformance(int n, int* speed, int* efficiency, int k) {
    // 1. Combine engineers' speed and efficiency into a single structure
    Engineer engineers[n];
    for (int i = 0; i < n; i++) {
        engineers[i].speed = speed[i];
        engineers[i].efficiency = efficiency[i];
    }

    // 2. Sort engineers by efficiency in descending order
    qsort(engineers, n, sizeof(Engineer), compareEngineers);

    // 3. Initialize a min-heap to store speeds and variables for calculation
    MinHeap* minHeap = heap_create(k); // Heap will store up to k speeds
    long long current_speed_sum = 0;
    long long max_perf = 0;

    // 4. Iterate through sorted engineers
    for (int i = 0; i < n; i++) {
        int current_speed = engineers[i].speed;
        int current_efficiency = engineers[i].efficiency;

        // Add current engineer's speed to the team
        // If heap size is less than k, just add
        if (minHeap->size < k) {
            heap_push(minHeap, current_speed);
            current_speed_sum += current_speed;
        } 
        // If heap is full (size k) and current speed is greater than the smallest speed in the heap
        else if (current_speed > heap_peek(minHeap)) {
            current_speed_sum -= heap_pop(minHeap); // Remove the smallest speed
            heap_push(minHeap, current_speed);      // Add the current (larger) speed
            current_speed_sum += current_speed;
        }
        // If heap is full and current_speed is not greater than the smallest in heap,
        // we don't add it, as it won't improve the sum of speeds for this efficiency.

        // Calculate performance with the current team (sum of speeds from heap, current engineer's efficiency)
        // The current_efficiency is the minimum efficiency of the team because engineers are sorted by efficiency descending.
        long long current_performance = current_speed_sum * current_efficiency;
        if (current_performance > max_perf) {
            max_perf = current_performance;
        }
    }

    // 5. Clean up heap memory
    heap_destroy(minHeap);

    return max_perf;
}