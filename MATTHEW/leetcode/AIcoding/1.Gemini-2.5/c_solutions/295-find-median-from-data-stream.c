#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* data;
    int capacity;
    int size;
} MinHeap;

MinHeap* minHeapCreate(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void minHeapSwap(MinHeap* heap, int i, int j) {
    int temp = heap->data[i];
    heap->data[i] = heap->data[j];
    heap->data[j] = temp;
}

void minHeapBubbleUp(MinHeap* heap, int index) {
    while (index > 0 && heap->data[index] < heap->data[(index - 1) / 2]) {
        minHeapSwap(heap, index, (index - 1) / 2);
        index = (index - 1) / 2;
    }
}

void minHeapBubbleDown(MinHeap* heap, int index) {
    int leftChild, rightChild, smallest;
    while (true) {
        leftChild = 2 * index + 1;
        rightChild = 2 * index + 2;
        smallest = index;

        if (leftChild < heap->size && heap->data[leftChild] < heap->data[smallest]) {
            smallest = leftChild;
        }
        if (rightChild < heap->size && heap->data[rightChild] < heap->data[smallest]) {
            smallest = rightChild;
        }

        if (smallest != index) {
            minHeapSwap(heap, index, smallest);
            index = smallest;
        } else {
            break;
        }
    }
}

void minHeapInsert(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (int*)realloc(heap->data, sizeof(int) * heap->capacity);
    }
    heap->data[heap->size++] = val;
    minHeapBubbleUp(heap, heap->size - 1);
}

int minHeapExtractMin(MinHeap* heap) {
    if (heap->size == 0) return -1; // Should not happen in this problem context
    int min = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    minHeapBubbleDown(heap, 0);
    return min;
}

int minHeapPeek(MinHeap* heap) {
    if (heap->size == 0) return -1;
    return heap->data[0];
}

void minHeapFree(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

typedef MinHeap MaxHeap;

MaxHeap* maxHeapCreate(int capacity) {
    return minHeapCreate(capacity); // Same structure
}

void maxHeapBubbleUp(MaxHeap* heap, int index) {
    while (index > 0 && heap->data[index] > heap->data[(index - 1) / 2]) { // Inverted comparison
        minHeapSwap(heap, index, (index - 1) / 2);
        index = (index - 1) / 2;
    }
}

void maxHeapBubbleDown(MaxHeap* heap, int index) {
    int leftChild, rightChild, largest;
    while (true) {
        leftChild = 2 * index + 1;
        rightChild = 2 * index + 2;
        largest = index;

        if (leftChild < heap->size && heap->data[leftChild] > heap->data[largest]) { // Inverted comparison
            largest = leftChild;
        }
        if (rightChild < heap->size && heap->data[rightChild] > heap->data[largest]) { // Inverted comparison
            largest = rightChild;
        }

        if (largest != index) {
            minHeapSwap(heap, index, largest);
            index = largest;
        } else {
            break;
        }
    }
}

void maxHeapInsert(MaxHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (int*)realloc(heap->data, sizeof(int) * heap->capacity);
    }
    heap->data[heap->size++] = val;
    maxHeapBubbleUp(heap, heap->size - 1);
}

int maxHeapExtractMax(MaxHeap* heap) {
    if (heap->size == 0) return -1;
    int max = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    maxHeapBubbleDown(heap, 0);
    return max;
}

int maxHeapPeek(MaxHeap* heap) {
    if (heap->size == 0) return -1;
    return heap->data[0];
}

void maxHeapFree(MaxHeap* heap) {
    minHeapFree(heap); // Same freeing logic
}

typedef struct {
    MaxHeap* maxHeap; // Stores the smaller half of numbers
    MinHeap* minHeap; // Stores the larger half of numbers
} MedianFinder;

MedianFinder* medianFinderCreate() {
    MedianFinder* obj = (MedianFinder*)malloc(sizeof(MedianFinder));
    obj->maxHeap = maxHeapCreate(10); // Initial capacity
    obj->minHeap = minHeapCreate(10); // Initial capacity
    return obj;
}

void medianFinderAddNum(MedianFinder* obj, int num) {
    if (obj->maxHeap->size == 0 || num <= maxHeapPeek(obj->maxHeap)) {
        maxHeapInsert(obj->maxHeap, num);
    } else {
        minHeapInsert(obj->minHeap, num);
    }

    // Balance the heaps
    if (obj->maxHeap->size > obj->minHeap->size + 1) {
        minHeapInsert(obj->minHeap, maxHeapExtractMax(obj->maxHeap));
    } else if (obj->minHeap->size > obj->maxHeap->size) {
        maxHeapInsert(obj->maxHeap, minHeapExtractMin(obj->minHeap));
    }
}

double medianFinderFindMedian(MedianFinder* obj) {
    if (obj->maxHeap->size > obj->minHeap->size) {
        return (double)maxHeapPeek(obj->maxHeap);
    } else {
        return ((double)maxHeapPeek(obj->maxHeap) + (double)minHeapPeek(obj->minHeap)) / 2.0;
    }
}

void medianFinderFree(MedianFinder* obj) {
    maxHeapFree(obj->maxHeap);
    minHeapFree(obj->minHeap);
    free(obj);
}