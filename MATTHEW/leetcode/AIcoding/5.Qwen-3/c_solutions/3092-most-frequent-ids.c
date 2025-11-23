#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int id;
    int count;
} IdCount;

typedef struct {
    IdCount* data;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (IdCount*)malloc(capacity * sizeof(IdCount));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(IdCount* a, IdCount* b) {
    IdCount temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap->data[index].count >= heap->data[parent].count) break;
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left].count < heap->data[smallest].count)
        smallest = left;
    if (right < heap->size && heap->data[right].count < heap->data[smallest].count)
        smallest = right;

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insert(MinHeap* heap, int id, int count) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (IdCount*)realloc(heap->data, heap->capacity * sizeof(IdCount));
    }
    heap->data[heap->size].id = id;
    heap->data[heap->size].count = count;
    heapifyUp(heap, heap->size);
    heap->size++;
}

IdCount extractMin(MinHeap* heap) {
    IdCount min = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return min;
}

int* mostFrequent(int** ids, int idsSize, int* idsColSize, int* returnSize) {
    int* result = (int*)malloc(idsSize * sizeof(int));
    *returnSize = idsSize;

    int* freq = (int*)calloc(100001, sizeof(int));
    MinHeap* heap = createMinHeap(1000);

    for (int i = 0; i < idsSize; i++) {
        int id = ids[i][0];
        freq[id]++;
        insert(heap, id, freq[id]);

        while (heap->size > 1) {
            IdCount top = heap->data[0];
            IdCount next = heap->data[1];
            if (top.count == next.count) {
                break;
            } else {
                extractMin(heap);
            }
        }

        result[i] = heap->data[0].id;
    }

    free(freq);
    free(heap->data);
    free(heap);
    return result;
}