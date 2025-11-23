#include <stdlib.h>
#include <limits.h>

static void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

static void max_heap_sift_up(MaxHeap* heap, int idx) {
    int parent_idx = (idx - 1) / 2;
    while (idx > 0 && heap->data[idx] > heap->data[parent_idx]) {
        swap(&heap->data[idx], &heap->data[parent_idx]);
        idx = parent_idx;
        parent_idx = (idx - 1) / 2;
    }
}

static void max_heap_sift_down(MaxHeap* heap, int idx) {
    int largest = idx;
    int left_child = 2 * idx + 1;
    int right_child = 2 * idx + 2;

    if (left_child < heap->size && heap->data[left_child] > heap->data[largest]) {
        largest = left_child;
    }
    if (right_child < heap->size && heap->data[right_child] > heap->data[largest]) {
        largest = right_child;
    }

    if (largest != idx) {
        swap(&heap->data[idx], &heap->data[largest]);
        max_heap_sift_down(heap, largest);
    }
}

static void max_heap_push(MaxHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        exit(EXIT_FAILURE); 
    }
    heap->data[heap->size] = val;
    heap->size++;
    max_heap_sift_up(heap, heap->size - 1);
}

static int max_heap_pop(MaxHeap* heap) {
    if (heap->size == 0) return INT_MIN; 
    int root_val = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    max_heap_sift_down(heap, 0);
    return root_val;
}

static int max_heap_top(MaxHeap* heap) {
    if (heap->size == 0) return INT_MIN;
    return heap->data[0];
}

typedef struct {
    int* data;
    int size;
    int capacity;
} MinHeap;

static void min_heap_sift_up(MinHeap* heap, int idx) {
    int parent_idx = (idx - 1) / 2;
    while (idx > 0 && heap->data[idx] < heap->data[parent_idx]) {
        swap(&heap->data[idx], &heap->data[parent_idx]);
        idx = parent_idx;
        parent_idx = (idx - 1) / 2;
    }
}

static void min_heap_sift_down(MinHeap* heap, int idx) {
    int smallest = idx;
    int left_child = 2 * idx + 1;
    int right_child = 2 * idx + 2;

    if (left_child < heap->size && heap->data[left_child] < heap->data[smallest]) {
        smallest = left_child;
    }
    if (right_child < heap->size && heap->data[right_child] < heap->data[smallest]) {
        smallest = right_child;
    }

    if (smallest != idx) {
        swap(&heap->data[idx], &heap->data[smallest]);
        min_heap_sift_down(heap, smallest);
    }
}

static void min_heap_push(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        exit(EXIT_FAILURE);
    }
    heap->data[heap->size] = val;
    heap->size++;
    min_heap_sift_up(heap, heap->size - 1);
}

static int min_heap_pop(MinHeap* heap) {
    if (heap->size == 0) return INT_MIN;
    int root_val = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    min_heap_sift_down(heap, 0);
    return root_val;
}

static int min_heap_top(MinHeap* heap) {
    if (heap->size == 0) return INT_MIN;
    return heap->data[0];
}

#define INITIAL_HEAP_CAPACITY 50005 

typedef struct {
    MaxHeap* max_heap; 
    MinHeap* min_heap; 
} MedianFinder;

MedianFinder* medianFinderCreate() {
    MedianFinder* obj = (MedianFinder*)malloc(sizeof(MedianFinder));

    obj->max_heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    obj->max_heap->data = (int*)malloc(sizeof(int) * INITIAL_HEAP_CAPACITY);
    obj->max_heap->size = 0;
    obj->max_heap->capacity = INITIAL_HEAP_CAPACITY;

    obj->min_heap = (MinHeap*)malloc(sizeof(MinHeap));
    obj->min_heap->data = (int*)malloc(sizeof(int) * INITIAL_HEAP_CAPACITY);
    obj->min_heap->size = 0;
    obj->min_heap->capacity = INITIAL_HEAP_CAPACITY;

    return obj;
}

void medianFinderAddNum(MedianFinder* obj, int num) {
    max_heap_push(obj->max_heap, num);

    if (obj->max_heap->size > 0 && obj->min_heap->size > 0 && max_heap_top(obj->max_heap) > min_heap_top(obj->min_heap)) {
        min_heap_push(obj->min_heap, max_heap_pop(obj->max_heap));
    }

    if (obj->max_heap->size > obj->min_heap->size + 1) {
        min_heap_push(obj->min_heap, max_heap_pop(obj->max_heap));
    } else if (obj->min_heap->size > obj->max_heap->size) { 
        max_heap_push(obj->max_heap, min_heap_pop(obj->min_heap));
    }
}

double medianFinderFindMedian(MedianFinder* obj) {
    if (obj->max_heap->size == obj->min_heap->size) {
        return ((double)max_heap_top(obj->max_heap) + (double)min_heap_top(obj->min_heap)) / 2.0;
    } else { 
        return (double)max_heap_top(obj->max_heap);
    }
}

void medianFinderFree(MedianFinder* obj) {
    if (obj) {
        if (obj->max_heap) {
            free(obj->max_heap->data);
            free(obj->max_heap);
        }
        if (obj->min_heap) {
            free(obj->min_heap->data);
            free(obj->min_heap);
        }
        free(obj);
    }
}