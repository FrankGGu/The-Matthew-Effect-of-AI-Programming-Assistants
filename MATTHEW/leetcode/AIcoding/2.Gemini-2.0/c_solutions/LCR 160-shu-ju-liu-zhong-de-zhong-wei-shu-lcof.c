#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* minHeap;
    int minHeapSize;
    int* maxHeap;
    int maxHeapSize;
    int capacity;
} MedianFinder;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(int* heap, int i, int size) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < size && heap[left] < heap[smallest]) {
        smallest = left;
    }

    if (right < size && heap[right] < heap[smallest]) {
        smallest = right;
    }

    if (smallest != i) {
        swap(&heap[i], &heap[smallest]);
        minHeapify(heap, smallest, size);
    }
}

void maxHeapify(int* heap, int i, int size) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < size && heap[left] > heap[largest]) {
        largest = left;
    }

    if (right < size && heap[right] > heap[largest]) {
        largest = right;
    }

    if (largest != i) {
        swap(&heap[i], &heap[largest]);
        maxHeapify(heap, largest, size);
    }
}

MedianFinder* medianFinderCreate() {
    MedianFinder* obj = (MedianFinder*)malloc(sizeof(MedianFinder));
    obj->capacity = 100000;
    obj->minHeap = (int*)malloc(sizeof(int) * obj->capacity);
    obj->maxHeap = (int*)malloc(sizeof(int) * obj->capacity);
    obj->minHeapSize = 0;
    obj->maxHeapSize = 0;
    return obj;
}

void medianFinderAddNum(MedianFinder* obj, int num) {
    if (obj->maxHeapSize == 0 || num <= obj->maxHeap[0]) {
        obj->maxHeap[obj->maxHeapSize++] = num;
        int i = obj->maxHeapSize - 1;
        while (i > 0 && obj->maxHeap[i] > obj->maxHeap[(i - 1) / 2]) {
            swap(&obj->maxHeap[i], &obj->maxHeap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    } else {
        obj->minHeap[obj->minHeapSize++] = num;
        int i = obj->minHeapSize - 1;
        while (i > 0 && obj->minHeap[i] < obj->minHeap[(i - 1) / 2]) {
            swap(&obj->minHeap[i], &obj->minHeap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    }

    if (obj->maxHeapSize > obj->minHeapSize + 1) {
        int temp = obj->maxHeap[0];
        obj->maxHeap[0] = obj->maxHeap[--obj->maxHeapSize];
        maxHeapify(obj->maxHeap, 0, obj->maxHeapSize);
        obj->minHeap[obj->minHeapSize++] = temp;
        int i = obj->minHeapSize - 1;
        while (i > 0 && obj->minHeap[i] < obj->minHeap[(i - 1) / 2]) {
            swap(&obj->minHeap[i], &obj->minHeap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    } else if (obj->minHeapSize > obj->maxHeapSize) {
        int temp = obj->minHeap[0];
        obj->minHeap[0] = obj->minHeap[--obj->minHeapSize];
        minHeapify(obj->minHeap, 0, obj->minHeapSize);
        obj->maxHeap[obj->maxHeapSize++] = temp;
        int i = obj->maxHeapSize - 1;
        while (i > 0 && obj->maxHeap[i] > obj->maxHeap[(i - 1) / 2]) {
            swap(&obj->maxHeap[i], &obj->maxHeap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    }
}

double medianFinderFindMedian(MedianFinder* obj) {
    if (obj->maxHeapSize == obj->minHeapSize) {
        if (obj->maxHeapSize == 0) return 0.0;
        return (double)(obj->maxHeap[0] + obj->minHeap[0]) / 2.0;
    } else {
        return (double)obj->maxHeap[0];
    }
}

void medianFinderFree(MedianFinder* obj) {
    free(obj->minHeap);
    free(obj->maxHeap);
    free(obj);
}