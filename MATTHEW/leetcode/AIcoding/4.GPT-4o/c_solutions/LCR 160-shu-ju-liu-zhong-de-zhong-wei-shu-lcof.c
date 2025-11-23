#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int *maxHeap;
    int *minHeap;
    int maxSize;
    int minSize;
} MedianFinder;

MedianFinder* medianFinderCreate() {
    MedianFinder* obj = (MedianFinder*)malloc(sizeof(MedianFinder));
    obj->maxHeap = (int*)malloc(10000 * sizeof(int));
    obj->minHeap = (int*)malloc(10000 * sizeof(int));
    obj->maxSize = 0;
    obj->minSize = 0;
    return obj;
}

void maxHeapInsert(MedianFinder* obj, int val) {
    obj->maxHeap[obj->maxSize++] = val;
    int i = obj->maxSize - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (obj->maxHeap[parent] >= obj->maxHeap[i]) break;
        int temp = obj->maxHeap[parent];
        obj->maxHeap[parent] = obj->maxHeap[i];
        obj->maxHeap[i] = temp;
        i = parent;
    }
}

void minHeapInsert(MedianFinder* obj, int val) {
    obj->minHeap[obj->minSize++] = val;
    int i = obj->minSize - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (obj->minHeap[parent] <= obj->minHeap[i]) break;
        int temp = obj->minHeap[parent];
        obj->minHeap[parent] = obj->minHeap[i];
        obj->minHeap[i] = temp;
        i = parent;
    }
}

void balanceHeaps(MedianFinder* obj) {
    if (obj->maxSize > obj->minSize + 1) {
        obj->minHeap[obj->minSize++] = obj->maxHeap[0];
        obj->maxHeap[0] = obj->maxHeap[--obj->maxSize];
        int i = 0;
        while (1) {
            int left = 2 * i + 1;
            int right = 2 * i + 2;
            int largest = i;
            if (left < obj->maxSize && obj->maxHeap[left] > obj->maxHeap[largest]) largest = left;
            if (right < obj->maxSize && obj->maxHeap[right] > obj->maxHeap[largest]) largest = right;
            if (largest == i) break;
            int temp = obj->maxHeap[i];
            obj->maxHeap[i] = obj->maxHeap[largest];
            obj->maxHeap[largest] = temp;
            i = largest;
        }
    } else if (obj->minSize > obj->maxSize) {
        obj->maxHeap[obj->maxSize++] = obj->minHeap[0];
        obj->minHeap[0] = obj->minHeap[--obj->minSize];
        int i = 0;
        while (1) {
            int left = 2 * i + 1;
            int right = 2 * i + 2;
            int smallest = i;
            if (left < obj->minSize && obj->minHeap[left] < obj->minHeap[smallest]) smallest = left;
            if (right < obj->minSize && obj->minHeap[right] < obj->minHeap[smallest]) smallest = right;
            if (smallest == i) break;
            int temp = obj->minHeap[i];
            obj->minHeap[i] = obj->minHeap[smallest];
            obj->minHeap[smallest] = temp;
            i = smallest;
        }
    }
}

void medianFinderAddNum(MedianFinder* obj, int num) {
    maxHeapInsert(obj, num);
    balanceHeaps(obj);
}

double medianFinderFindMedian(MedianFinder* obj) {
    if (obj->maxSize > obj->minSize) return (double)obj->maxHeap[0];
    return (obj->maxHeap[0] + obj->minHeap[0]) / 2.0;
}

void medianFinderFree(MedianFinder* obj) {
    free(obj->maxHeap);
    free(obj->minHeap);
    free(obj);
}