#include <stdlib.h> // For malloc, free, qsort
#include <float.h>  // For DBL_MAX

typedef struct {
    double ratio;
    int quality;
} Worker;

int compareWorkers(const void *a, const void *b) {
    Worker *workerA = (Worker *)a;
    Worker *workerB = (Worker *)b;
    if (workerA->ratio < workerB->ratio) return -1;
    if (workerA->ratio > workerB->ratio) return 1;
    return 0;
}

static int* heap_arr;
static int heap_size;
static int heap_capacity;

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void sift_up(int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap_arr[idx] > heap_arr[parent]) {
        swap(&heap_arr[idx], &heap_arr[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void sift_down(int idx) {
    int left_child = 2 * idx + 1;
    int right_child = 2 * idx + 2;
    int largest = idx;

    if (left_child < heap_size && heap_arr[left_child] > heap_arr[largest]) {
        largest = left_child;
    }
    if (right_child < heap_size && heap_arr[right_child] > heap_arr[largest]) {
        largest = right_child;
    }

    if (largest != idx) {
        swap(&heap_arr[idx], &heap_arr[largest]);
        sift_down(largest);
    }
}

void heap_push(int val) {
    heap_arr[heap_size] = val;
    sift_up(heap_size);
    heap_size++;
}

void heap_pop() {
    if (heap_size == 0) return;
    heap_arr[0] = heap_arr[heap_size - 1];
    heap_size--;
    if (heap_size > 0) { // Only sift down if there are elements left
        sift_down(0);
    }
}

int heap_top() {
    if (heap_size == 0) return -1; 
    return heap_arr[0];
}

int heap_get_size() {
    return heap_size;
}

void heap_init(int capacity) {
    heap_capacity = capacity;
    heap_arr = (int*)malloc(sizeof(int) * capacity);
    heap_size = 0;
}

void heap_destroy() {
    free(heap_arr);
    heap_arr = NULL;
    heap_size = 0;
    heap_capacity = 0;
}

double mincostToHireWorkers(int* quality, int qualitySize, int* wage, int wageSize, int k) {
    // Create an array of Worker structs
    Worker* workers = (Worker*)malloc(sizeof(Worker) * qualitySize);
    for (int i = 0; i < qualitySize; ++i) {
        workers[i].ratio = (double)wage[i] / quality[i];
        workers[i].quality = quality[i];
    }

    // Sort workers by their wage/quality ratio
    qsort(workers, qualitySize, sizeof(Worker), compareWorkers);

    // Initialize the max-heap for storing qualities
    heap_init(qualitySize); // Max capacity is N

    double min_cost = DBL_MAX;
    long long current_quality_sum = 0; // Sum of qualities of workers in the current group

    // Iterate through the sorted workers
    for (int i = 0; i < qualitySize; ++i) {
        current_quality_sum += workers[i].quality;
        heap_push(workers[i].quality);

        // If heap size exceeds k, remove the largest quality
        // This ensures we keep the k smallest qualities for the current ratio
        if (heap_get_size() > k) {
            current_quality_sum -= heap_top();
            heap_pop();
        }

        // If we have exactly k workers in the heap, calculate the cost
        if (heap_get_size() == k) {
            // The current worker (workers[i]) sets the maximum ratio for the group
            double current_cost = workers[i].ratio * current_quality_sum;
            if (current_cost < min_cost) {
                min_cost = current_cost;
            }
        }
    }

    // Clean up allocated memory
    free(workers);
    heap_destroy();

    return min_cost;
}