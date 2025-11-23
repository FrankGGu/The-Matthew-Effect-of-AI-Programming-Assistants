#include <stdlib.h>

typedef struct {
    double* data;
    int size;
    int capacity;
} MaxHeap;

void swap(double* a, double* b) {
    double temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MaxHeap* heap, int idx) {
    if (idx == 0) return;
    int parent = (idx - 1) / 2;
    if (heap->data[parent] < heap->data[idx]) {
        swap(&heap->data[parent], &heap->data[idx]);
        heapifyUp(heap, parent);
    }
}

void heapifyDown(MaxHeap* heap, int idx) {
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;
    int largest = idx;

    if (left < heap->size && heap->data[left] > heap->data[largest]) {
        largest = left;
    }
    if (right < heap->size && heap->data[right] > heap->data[largest]) {
        largest = right;
    }

    if (largest != idx) {
        swap(&heap->data[idx], &heap->data[largest]);
        heapifyDown(heap, largest);
    }
}

void push(MaxHeap* heap, double value) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = realloc(heap->data, heap->capacity * sizeof(double));
    }
    heap->data[heap->size] = value;
    heapifyUp(heap, heap->size);
    heap->size++;
}

double pop(MaxHeap* heap) {
    if (heap->size == 0) return 0;
    double max = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return max;
}

int halveArray(int* nums, int numsSize) {
    double sum = 0;
    MaxHeap heap;
    heap.size = 0;
    heap.capacity = numsSize;
    heap.data = malloc(heap.capacity * sizeof(double));

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        push(&heap, nums[i]);
    }

    double target = sum / 2.0;
    int operations = 0;
    double reduced = 0;

    while (reduced < target) {
        double max = pop(&heap);
        double half = max / 2.0;
        reduced += half;
        push(&heap, half);
        operations++;
    }

    free(heap.data);
    return operations;
}