#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* heap;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->heap = (int*)malloc(sizeof(int) * (capacity + 1));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    return minHeap;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap* minHeap, int index) {
    int smallest = index;
    int left = 2 * index;
    int right = 2 * index + 1;

    if (left <= minHeap->size && minHeap->heap[left] < minHeap->heap[smallest]) {
        smallest = left;
    }

    if (right <= minHeap->size && minHeap->heap[right] < minHeap->heap[smallest]) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&minHeap->heap[index], &minHeap->heap[smallest]);
        minHeapify(minHeap, smallest);
    }
}

void insert(MinHeap* minHeap, int val) {
    if (minHeap->size == minHeap->capacity) {
        return;
    }

    minHeap->size++;
    minHeap->heap[minHeap->size] = val;

    int i = minHeap->size;
    while (i > 1 && minHeap->heap[i / 2] > minHeap->heap[i]) {
        swap(&minHeap->heap[i / 2], &minHeap->heap[i]);
        i /= 2;
    }
}

int extractMin(MinHeap* minHeap) {
    if (minHeap->size == 0) {
        return -1;
    }

    int min = minHeap->heap[1];
    minHeap->heap[1] = minHeap->heap[minHeap->size];
    minHeap->size--;
    minHeapify(minHeap, 1);

    return min;
}

typedef struct {
    MinHeap* minHeap;
    int nextInteger;
} SmallestInfiniteSet;

SmallestInfiniteSet* smallestInfiniteSetCreate() {
    SmallestInfiniteSet* obj = (SmallestInfiniteSet*)malloc(sizeof(SmallestInfiniteSet));
    obj->minHeap = createMinHeap(1000);
    obj->nextInteger = 1;
    return obj;
}

int smallestInfiniteSetPopSmallest(SmallestInfiniteSet* obj) {
    if (obj->minHeap->size > 0) {
        return extractMin(obj->minHeap);
    } else {
        return obj->nextInteger++;
    }
}

void smallestInfiniteSetAddBack(SmallestInfiniteSet* obj, int num) {
    if (num < obj->nextInteger) {
        int found = 0;
        for(int i = 1; i <= obj->minHeap->size; i++) {
            if(obj->minHeap->heap[i] == num) {
                found = 1;
                break;
            }
        }
        if (!found) {
            insert(obj->minHeap, num);
        }
    }
}

void smallestInfiniteSetFree(SmallestInfiniteSet* obj) {
    free(obj->minHeap->heap);
    free(obj->minHeap);
    free(obj);
}