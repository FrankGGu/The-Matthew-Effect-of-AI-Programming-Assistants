#include <stdlib.h>

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyDown(int* heap, int heapSize, int idx) {
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
        heapifyDown(heap, heapSize, largest);
    }
}

void heapifyUp(int* heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap[parent] < heap[idx]) {
        swap(&heap[parent], &heap[idx]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void insert(int* heap, int* heapSize, int val) {
    heap[*heapSize] = val;
    (*heapSize)++;
    heapifyUp(heap, *heapSize - 1);
}

int extractMax(int* heap, int* heapSize) {
    int maxVal = heap[0];
    heap[0] = heap[*heapSize - 1];
    (*heapSize)--;
    heapifyDown(heap, *heapSize, 0);
    return maxVal;
}

void buildHeap(int* heap, int heapSize) {
    for (int i = heapSize / 2 - 1; i >= 0; i--) {
        heapifyDown(heap, heapSize, i);
    }
}

int minStoneSum(int* piles, int pilesSize, int k) {
    int currentHeapSize = pilesSize;

    buildHeap(piles, currentHeapSize);

    for (int i = 0; i < k; i++) {
        int currentMax = extractMax(piles, &currentHeapSize);
        int newVal = currentMax - (currentMax / 2);
        insert(piles, &currentHeapSize, newVal);
    }

    int totalStones = 0;
    for (int i = 0; i < currentHeapSize; i++) {
        totalStones += piles[i];
    }

    return totalStones;
}