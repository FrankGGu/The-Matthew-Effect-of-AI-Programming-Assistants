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

void siftDown(MaxHeap* heap, int idx) {
    int leftChild = 2 * idx + 1;
    int rightChild = 2 * idx + 2;
    int largest = idx;

    if (leftChild < heap->size && heap->data[leftChild] > heap->data[largest]) {
        largest = leftChild;
    }
    if (rightChild < heap->size && heap->data[rightChild] > heap->data[largest]) {
        largest = rightChild;
    }

    if (largest != idx) {
        swap(&heap->data[idx], &heap->data[largest]);
        siftDown(heap, largest);
    }
}

void siftUp(MaxHeap* heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap->data[idx] > heap->data[parent]) {
        swap(&heap->data[idx], &heap->data[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

MaxHeap* createMaxHeapFromArray(int* arr, int size) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->data = (double*)malloc(sizeof(double) * size);
    heap->size = size;
    heap->capacity = size;

    for (int i = 0; i < size; i++) {
        heap->data[i] = (double)arr[i];
    }

    for (int i = (heap->size / 2) - 1; i >= 0; i--) {
        siftDown(heap, i);
    }
    return heap;
}

void insertMaxHeap(MaxHeap* heap, double value) {
    heap->data[heap->size] = value;
    heap->size++;
    siftUp(heap, heap->size - 1);
}

double extractMax(MaxHeap* heap) {
    double maxVal = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    siftDown(heap, 0);
    return maxVal;
}

void freeMaxHeap(MaxHeap* heap) {
    free(heap->data);
    free(heap);
}

int minOperations(int* nums, int numsSize) {
    double initialSum = 0.0;
    for (int i = 0; i < numsSize; i++) {
        initialSum += nums[i];
    }

    double targetReduction = initialSum / 2.0;
    double currentReduction = 0.0;
    int operations = 0;

    MaxHeap* heap = createMaxHeapFromArray(nums, numsSize);

    while (currentReduction < targetReduction) {
        double maxVal = extractMax(heap);
        currentReduction += maxVal / 2.0;
        operations++;
        insertMaxHeap(heap, maxVal / 2.0);
    }

    freeMaxHeap(heap);
    return operations;
}