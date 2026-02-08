#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *data;
    int size;
    int capacity;
} Heap;

Heap* createHeap(int capacity) {
    Heap* heap = (Heap*)malloc(sizeof(Heap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapify(Heap* heap, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < heap->size && heap->data[left] > heap->data[largest]) {
        largest = left;
    }

    if (right < heap->size && heap->data[right] > heap->data[largest]) {
        largest = right;
    }

    if (largest != i) {
        swap(&heap->data[i], &heap->data[largest]);
        heapify(heap, largest);
    }
}

void insert(Heap* heap, int value) {
    if (heap->size == heap->capacity) {
        return;
    }

    heap->data[heap->size] = value;
    int i = heap->size;
    heap->size++;

    while (i > 0 && heap->data[i] > heap->data[(i - 1) / 2]) {
        swap(&heap->data[i], &heap->data[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int extractMax(Heap* heap) {
    if (heap->size <= 0) {
        return -1;
    }

    if (heap->size == 1) {
        heap->size = 0;
        return heap->data[0];
    }

    int root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapify(heap, 0);

    return root;
}

void freeHeap(Heap* heap) {
    free(heap->data);
    free(heap);
}

bool isPossible(int* target, int targetSize) {
    if (targetSize == 1) {
        return target[0] == 1;
    }

    Heap* heap = createHeap(targetSize);
    long long sum = 0;
    for (int i = 0; i < targetSize; i++) {
        insert(heap, target[i]);
        sum += target[i];
    }

    while (true) {
        int largest = extractMax(heap);
        long long restSum = sum - largest;

        if (largest == 1) {
            return true;
        }

        if (largest <= restSum || restSum == 0) {
            return false;
        }

        int prev = largest % (int)restSum;
        if (prev == 0) prev = (int)restSum;

        sum = restSum + prev;
        insert(heap, prev);

        if (prev == largest) return false;
    }

    freeHeap(heap);
    return true;
}