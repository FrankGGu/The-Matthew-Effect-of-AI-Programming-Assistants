#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* maxHeap;
    int maxHeapSize;
    int maxHeapCapacity;
    int* minHeap;
    int minHeapSize;
    int minHeapCapacity;
} MedianFinder;

MedianFinder* medianFinderCreate() {
    MedianFinder* obj = (MedianFinder*)malloc(sizeof(MedianFinder));
    obj->maxHeap = (int*)malloc(sizeof(int) * 10);
    obj->maxHeapCapacity = 10;
    obj->maxHeapSize = 0;
    obj->minHeap = (int*)malloc(sizeof(int) * 10);
    obj->minHeapCapacity = 10;
    obj->minHeapSize = 0;
    return obj;
}

void maxHeapify(MedianFinder* obj, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    if (left < obj->maxHeapSize && obj->maxHeap[left] > obj->maxHeap[largest]) {
        largest = left;
    }
    if (right < obj->maxHeapSize && obj->maxHeap[right] > obj->maxHeap[largest]) {
        largest = right;
    }
    if (largest != i) {
        int temp = obj->maxHeap[i];
        obj->maxHeap[i] = obj->maxHeap[largest];
        obj->maxHeap[largest] = temp;
        maxHeapify(obj, largest);
    }
}

void minHeapify(MedianFinder* obj, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    if (left < obj->minHeapSize && obj->minHeap[left] < obj->minHeap[smallest]) {
        smallest = left;
    }
    if (right < obj->minHeapSize && obj->minHeap[right] < obj->minHeap[smallest]) {
        smallest = right;
    }
    if (smallest != i) {
        int temp = obj->minHeap[i];
        obj->minHeap[i] = obj->minHeap[smallest];
        obj->minHeap[smallest] = temp;
        minHeapify(obj, smallest);
    }
}

void pushMaxHeap(MedianFinder* obj, int val) {
    if (obj->maxHeapSize == obj->maxHeapCapacity) {
        obj->maxHeap = (int*)realloc(obj->maxHeap, sizeof(int) * (obj->maxHeapCapacity * 2));
        obj->maxHeapCapacity *= 2;
    }
    obj->maxHeap[obj->maxHeapSize++] = val;
    int i = obj->maxHeapSize - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (obj->maxHeap[parent] >= obj->maxHeap[i]) break;
        int temp = obj->maxHeap[parent];
        obj->maxHeap[parent] = obj->maxHeap[i];
        obj->maxHeap[i] = temp;
        i = parent;
    }
}

void pushMinHeap(MedianFinder* obj, int val) {
    if (obj->minHeapSize == obj->minHeapCapacity) {
        obj->minHeap = (int*)realloc(obj->minHeap, sizeof(int) * (obj->minHeapCapacity * 2));
        obj->minHeapCapacity *= 2;
    }
    obj->minHeap[obj->minHeapSize++] = val;
    int i = obj->minHeapSize - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (obj->minHeap[parent] <= obj->minHeap[i]) break;
        int temp = obj->minHeap[parent];
        obj->minHeap[parent] = obj->minHeap[i];
        obj->minHeap[i] = temp;
        i = parent;
    }
}

void popMaxHeap(MedianFinder* obj) {
    if (obj->maxHeapSize == 0) return;
    obj->maxHeap[0] = obj->maxHeap[--obj->maxHeapSize];
    maxHeapify(obj, 0);
}

void popMinHeap(MedianFinder* obj) {
    if (obj->minHeapSize == 0) return;
    obj->minHeap[0] = obj->minHeap[--obj->minHeapSize];
    minHeapify(obj, 0);
}

void medianFinderAddNum(MedianFinder* obj, int num) {
    if (obj->maxHeapSize == 0 || num <= obj->maxHeap[0]) {
        pushMaxHeap(obj, num);
    } else {
        pushMinHeap(obj, num);
    }

    if (obj->maxHeapSize > obj->minHeapSize + 1) {
        pushMinHeap(obj, obj->maxHeap[0]);
        popMaxHeap(obj);
    } else if (obj->minHeapSize > obj->maxHeapSize) {
        pushMaxHeap(obj, obj->minHeap[0]);
        popMinHeap(obj);
    }
}

double medianFinderFindMedian(MedianFinder* obj) {
    if (obj->maxHeapSize == obj->minHeapSize) {
        return (obj->maxHeap[0] + obj->minHeap[0]) / 2.0;
    } else {
        return obj->maxHeap[0];
    }
}

void medianFinderFree(MedianFinder* obj) {
    free(obj->maxHeap);
    free(obj->minHeap);
    free(obj);
}