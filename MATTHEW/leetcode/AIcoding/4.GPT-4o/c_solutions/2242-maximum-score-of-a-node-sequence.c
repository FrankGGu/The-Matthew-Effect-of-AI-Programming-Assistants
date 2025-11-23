#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *array;
    int size;
} MaxHeap;

MaxHeap* createMaxHeap(int size) {
    MaxHeap *heap = (MaxHeap *)malloc(sizeof(MaxHeap));
    heap->array = (int *)malloc(sizeof(int) * size);
    heap->size = 0;
    return heap;
}

void insertMaxHeap(MaxHeap *heap, int val) {
    heap->array[heap->size++] = val;
    int i = heap->size - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->array[i] > heap->array[parent]) {
            int temp = heap->array[i];
            heap->array[i] = heap->array[parent];
            heap->array[parent] = temp;
            i = parent;
        } else {
            break;
        }
    }
}

int extractMax(MaxHeap *heap) {
    int maxVal = heap->array[0];
    heap->array[0] = heap->array[--heap->size];
    int i = 0;
    while (i < heap->size) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int largest = i;
        if (left < heap->size && heap->array[left] > heap->array[largest]) {
            largest = left;
        }
        if (right < heap->size && heap->array[right] > heap->array[largest]) {
            largest = right;
        }
        if (largest != i) {
            int temp = heap->array[i];
            heap->array[i] = heap->array[largest];
            heap->array[largest] = temp;
            i = largest;
        } else {
            break;
        }
    }
    return maxVal;
}

void freeMaxHeap(MaxHeap *heap) {
    free(heap->array);
    free(heap);
}

int maximumScore(int* nums, int numsSize, int* edges, int edgesSize) {
    MaxHeap *heap = createMaxHeap(numsSize);
    for (int i = 0; i < numsSize; i++) {
        insertMaxHeap(heap, nums[i]);
    }

    int maxScore = 0;
    for (int i = 0; i < edgesSize; i += 2) {
        int u = edges[i];
        int v = edges[i + 1];
        maxScore = fmax(maxScore, nums[u] + nums[v] + extractMax(heap));
    }

    freeMaxHeap(heap);
    return maxScore;
}