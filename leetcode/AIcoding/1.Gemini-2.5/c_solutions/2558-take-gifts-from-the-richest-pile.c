#include <stdlib.h>
#include <math.h>

void swap(long long *a, long long *b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void siftDown(long long *heap, int heapSize, int idx) {
    int largest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heapSize && heap[left] > heap[largest]) {
        largest = left;
    }

    if (right < heapSize && heap[right] > heap[largest]) {
        largest = right;
    }

    if (largest != idx) {
        swap(&heap[idx], &heap[largest]);
        siftDown(heap, heapSize, largest);
    }
}

void buildMaxHeap(long long *heap, int heapSize) {
    for (int i = heapSize / 2 - 1; i >= 0; i--) {
        siftDown(heap, heapSize, i);
    }
}

long long extractMax(long long *heap, int *heapSizePtr) {
    long long maxVal = heap[0];
    heap[0] = heap[*heapSizePtr - 1];
    (*heapSizePtr)--;
    siftDown(heap, *heapSizePtr, 0);
    return maxVal;
}

void insertHeap(long long *heap, int *heapSizePtr, long long val) {
    (*heapSizePtr)++;
    int idx = *heapSizePtr - 1;
    heap[idx] = val;

    while (idx > 0 && heap[(idx - 1) / 2] < heap[idx]) {
        swap(&heap[idx], &heap[(idx - 1) / 2]);
        idx = (idx - 1) / 2;
    }
}

long long pickGifts(int* gifts, int giftsSize, int k) {
    long long *heap = (long long *)malloc(giftsSize * sizeof(long long));

    for (int i = 0; i < giftsSize; i++) {
        heap[i] = (long long)gifts[i];
    }

    int heapSize = giftsSize;

    buildMaxHeap(heap, heapSize);

    for (int i = 0; i < k; i++) {
        long long maxVal = extractMax(heap, &heapSize);

        if (maxVal == 1) {
            insertHeap(heap, &heapSize, 1);
            break;
        }

        long long newVal = (long long)floor(sqrt((double)maxVal));
        insertHeap(heap, &heapSize, newVal);
    }

    long long totalGifts = 0;
    for (int i = 0; i < heapSize; i++) {
        totalGifts += heap[i];
    }

    free(heap);

    return totalGifts;
}