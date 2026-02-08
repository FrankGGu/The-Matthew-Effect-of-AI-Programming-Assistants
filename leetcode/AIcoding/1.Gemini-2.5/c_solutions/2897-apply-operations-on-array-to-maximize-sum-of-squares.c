#include <stdlib.h> // For malloc, free

#define MOD 1000000007

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void initMaxHeap(MaxHeap* heap, int capacity) {
    heap->data = (int*)malloc(sizeof(int) * (capacity + 1)); // 1-indexed
    heap->size = 0;
    heap->capacity = capacity;
}

void freeMaxHeap(MaxHeap* heap) {
    free(heap->data);
    heap->data = NULL;
    heap->size = 0;
    heap->capacity = 0;
}

void heapifyUp(MaxHeap* heap, int index) {
    while (index > 1 && heap->data[index] > heap->data[index / 2]) {
        swap(&heap->data[index], &heap->data[index / 2]);
        index /= 2;
    }
}

void heapifyDown(MaxHeap* heap, int index) {
    int largest = index;
    int left = 2 * index;
    int right = 2 * index + 1;

    if (left <= heap->size && heap->data[left] > heap->data[largest]) {
        largest = left;
    }

    if (right <= heap->size && heap->data[right] > heap->data[largest]) {
        largest = right;
    }

    if (largest != index) {
        swap(&heap->data[index], &heap->data[largest]);
        heapifyDown(heap, largest);
    }
}

void insertMaxHeap(MaxHeap* heap, int val) {
    if (heap->size >= heap->capacity) {
        return;
    }
    heap->size++;
    heap->data[heap->size] = val;
    heapifyUp(heap, heap->size);
}

int extractMaxHeap(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1; 
    }
    int maxVal = heap->data[1];
    heap->data[1] = heap->data[heap->size];
    heap->size--;
    heapifyDown(heap, 1);
    return maxVal;
}

void buildMaxHeap(MaxHeap* heap, int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        heap->data[i + 1] = nums[i]; // Copy to 1-indexed heap
    }
    heap->size = numsSize;

    for (int i = heap->size / 2; i >= 1; i--) {
        heapifyDown(heap, i);
    }
}

long long maximizeSumOfSquares(int* nums, int numsSize, int k) {
    MaxHeap heap;
    initMaxHeap(&heap, numsSize);

    buildMaxHeap(&heap, nums, numsSize);

    for (int i = 0; i < k; i++) {
        int currentMax = extractMaxHeap(&heap);
        if (currentMax == -1) {
            break;
        }
        int newVal = (currentMax + 1) / 2; // Equivalent to ceil(currentMax / 2) for positive integers
        insertMaxHeap(&heap, newVal);
    }

    long long totalSumOfSquares = 0;
    for (int i = 1; i <= heap.size; i++) {
        long long val = heap.data[i];
        totalSumOfSquares = (totalSumOfSquares + (val * val) % MOD) % MOD;
    }

    freeMaxHeap(&heap);

    return totalSumOfSquares;
}