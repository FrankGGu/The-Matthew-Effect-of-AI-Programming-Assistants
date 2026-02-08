#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} MinHeap;

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void pushMinHeap(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) return;
    int i = heap->size++;
    while (i > 0 && val < heap->data[(i - 1) / 2]) {
        heap->data[i] = heap->data[(i - 1) / 2];
        i = (i - 1) / 2;
    }
    heap->data[i] = val;
}

int popMinHeap(MinHeap* heap) {
    if (heap->size == 0) return INT_MIN;
    int root = heap->data[0];
    int last = heap->data[--heap->size];
    int i = 0;
    while (i * 2 + 1 < heap->size) {
        int child = i * 2 + 1;
        if (child + 1 < heap->size && heap->data[child + 1] < heap->data[child]) {
            child++;
        }
        if (last <= heap->data[child]) break;
        heap->data[i] = heap->data[child];
        i = child;
    }
    heap->data[i] = last;
    return root;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

MaxHeap* createMaxHeap(int capacity) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void pushMaxHeap(MaxHeap* heap, int val) {
    if (heap->size == heap->capacity) return;
    int i = heap->size++;
    while (i > 0 && val > heap->data[(i - 1) / 2]) {
        heap->data[i] = heap->data[(i - 1) / 2];
        i = (i - 1) / 2;
    }
    heap->data[i] = val;
}

int popMaxHeap(MaxHeap* heap) {
    if (heap->size == 0) return INT_MIN;
    int root = heap->data[0];
    int last = heap->data[--heap->size];
    int i = 0;
    while (i * 2 + 1 < heap->size) {
        int child = i * 2 + 1;
        if (child + 1 < heap->size && heap->data[child + 1] > heap->data[child]) {
            child++;
        }
        if (last >= heap->data[child]) break;
        heap->data[i] = heap->data[child];
        i = child;
    }
    heap->data[i] = last;
    return root;
}

void freeMaxHeap(MaxHeap* heap) {
    free(heap->data);
    free(heap);
}

typedef struct {
    int m;
    int k;
    int* queue;
    int q_size;
    int q_capacity;
    MinHeap* min_heap;
    MaxHeap* max_heap;
    MinHeap* middle_heap;
    int total;
    int count;
} MKAverage;

MKAverage* mkAverageCreate(int m, int k) {
    MKAverage* obj = (MKAverage*)malloc(sizeof(MKAverage));
    obj->m = m;
    obj->k = k;
    obj->q_size = 0;
    obj->q_capacity = m;
    obj->queue = (int*)malloc(m * sizeof(int));
    obj->min_heap = createMinHeap(m);
    obj->max_heap = createMaxHeap(m);
    obj->middle_heap = createMinHeap(m);
    obj->total = 0;
    obj->count = 0;
    return obj;
}

void mkAverageAdd(MKAverage* obj, int num) {
    if (obj->q_size < obj->m) {
        obj->queue[obj->q_size++] = num;
        pushMinHeap(obj->min_heap, num);
        pushMaxHeap(obj->max_heap, num);
        pushMinHeap(obj->middle_heap, num);
    } else {
        obj->total -= obj->queue[obj->q_size % obj->m];
        obj->queue[obj->q_size % obj->m] = num;
        obj->total += num;
        obj->q_size++;
    }

    if (obj->q_size >= obj->m) {
        int temp = obj->queue[(obj->q_size - 1) % obj->m];
        pushMinHeap(obj->min_heap, temp);
        pushMaxHeap(obj->max_heap, temp);
        pushMinHeap(obj->middle_heap, temp);
    }

    obj->count++;
}

int mkAverageCalculate(MKAverage* obj) {
    if (obj->count < obj->m) return -1;
    int sum = 0;
    for (int i = 0; i < obj->m; i++) {
        sum += obj->queue[i];
    }
    return sum / obj->m;
}

void mkAverageFree(MKAverage* obj) {
    free(obj->queue);
    freeMinHeap(obj->min_heap);
    freeMaxHeap(obj->max_heap);
    freeMinHeap(obj->middle_heap);
    free(obj);
}