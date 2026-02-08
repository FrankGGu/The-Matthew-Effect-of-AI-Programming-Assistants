#include <stdlib.h>
#include <string.h>

typedef struct {
    int *arr;
    int size;
    int capacity;
} Heap;

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

Heap* createHeap(int capacity) {
    Heap *heap = (Heap*)malloc(sizeof(Heap));
    heap->arr = (int*)malloc(sizeof(int) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void freeHeap(Heap *heap) {
    free(heap->arr);
    free(heap);
}

void maxHeapifyUp(Heap *heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->arr[parent] >= heap->arr[idx]) break;
        swap(&heap->arr[parent], &heap->arr[idx]);
        idx = parent;
    }
}

void minHeapifyUp(Heap *heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->arr[parent] <= heap->arr[idx]) break;
        swap(&heap->arr[parent], &heap->arr[idx]);
        idx = parent;
    }
}

void maxHeapifyDown(Heap *heap, int idx) {
    while (1) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int largest = idx;

        if (left < heap->size && heap->arr[left] > heap->arr[largest])
            largest = left;
        if (right < heap->size && heap->arr[right] > heap->arr[largest])
            largest = right;
        if (largest == idx) break;

        swap(&heap->arr[idx], &heap->arr[largest]);
        idx = largest;
    }
}

void minHeapifyDown(Heap *heap, int idx) {
    while (1) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int smallest = idx;

        if (left < heap->size && heap->arr[left] < heap->arr[smallest])
            smallest = left;
        if (right < heap->size && heap->arr[right] < heap->arr[smallest])
            smallest = right;
        if (smallest == idx) break;

        swap(&heap->arr[idx], &heap->arr[smallest]);
        idx = smallest;
    }
}

void maxHeapPush(Heap *heap, int val) {
    if (heap->size == heap->capacity) return;
    heap->arr[heap->size] = val;
    maxHeapifyUp(heap, heap->size);
    heap->size++;
}

void minHeapPush(Heap *heap, int val) {
    if (heap->size == heap->capacity) return;
    heap->arr[heap->size] = val;
    minHeapifyUp(heap, heap->size);
    heap->size++;
}

int maxHeapPop(Heap *heap) {
    if (heap->size == 0) return -1;
    int val = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    maxHeapifyDown(heap, 0);
    return val;
}

int minHeapPop(Heap *heap) {
    if (heap->size == 0) return -1;
    int val = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    minHeapifyDown(heap, 0);
    return val;
}

int maxHeapTop(Heap *heap) {
    if (heap->size == 0) return -1;
    return heap->arr[0];
}

int minHeapTop(Heap *heap) {
    if (heap->size == 0) return -1;
    return heap->arr[0];
}

void balanceHeaps(Heap *maxHeap, Heap *minHeap) {
    while (maxHeap->size > minHeap->size + 1) {
        int val = maxHeapPop(maxHeap);
        minHeapPush(minHeap, val);
    }
    while (minHeap->size > maxHeap->size) {
        int val = minHeapPop(minHeap);
        maxHeapPush(maxHeap, val);
    }
}

void removeElement(Heap *heap, int val, int isMaxHeap) {
    int i;
    for (i = 0; i < heap->size; i++) {
        if (heap->arr[i] == val) break;
    }
    if (i == heap->size) return;

    heap->arr[i] = heap->arr[heap->size - 1];
    heap->size--;

    if (isMaxHeap) {
        if (i > 0 && heap->arr[i] > heap->arr[(i - 1) / 2])
            maxHeapifyUp(heap, i);
        else
            maxHeapifyDown(heap, i);
    } else {
        if (i > 0 && heap->arr[i] < heap->arr[(i - 1) / 2])
            minHeapifyUp(heap, i);
        else
            minHeapifyDown(heap, i);
    }
}

double* medianSlidingWindow(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize - k + 1;
    double *result = (double*)malloc(sizeof(double) * (*returnSize));

    Heap *maxHeap = createHeap(numsSize);
    Heap *minHeap = createHeap(numsSize);

    for (int i = 0; i < numsSize; i++) {
        if (maxHeap->size == 0 || nums[i] <= maxHeapTop(maxHeap)) {
            maxHeapPush(maxHeap, nums[i]);
        } else {
            minHeapPush(minHeap, nums[i]);
        }
        balanceHeaps(maxHeap, minHeap);

        if (i >= k - 1) {
            if (k % 2 == 1) {
                result[i - k + 1] = (double)maxHeapTop(maxHeap);
            } else {
                result[i - k + 1] = ((double)maxHeapTop(maxHeap) + (double)minHeapTop(minHeap)) / 2.0;
            }

            int toRemove = nums[i - k + 1];
            if (toRemove <= maxHeapTop(maxHeap)) {
                removeElement(maxHeap, toRemove, 1);
            } else {
                removeElement(minHeap, toRemove, 0);
            }
            balanceHeaps(maxHeap, minHeap);
        }
    }

    freeHeap(maxHeap);
    freeHeap(minHeap);

    return result;
}