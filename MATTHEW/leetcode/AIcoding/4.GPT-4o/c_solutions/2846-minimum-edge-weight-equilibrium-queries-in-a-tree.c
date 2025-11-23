#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int u, v, w;
} Edge;

typedef struct {
    int *data;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap *heap = (MinHeap *)malloc(sizeof(MinHeap));
    heap->data = (int *)malloc(capacity * sizeof(int));
    heap->size = 0;
    return heap;
}

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap *heap, int idx) {
    int smallest = idx, left = 2 * idx + 1, right = 2 * idx + 2;
    if (left < heap->size && heap->data[left] < heap->data[smallest])
        smallest = left;
    if (right < heap->size && heap->data[right] < heap->data[smallest])
        smallest = right;
    if (smallest != idx) {
        swap(&heap->data[smallest], &heap->data[idx]);
        minHeapify(heap, smallest);
    }
}

void insertMinHeap(MinHeap *heap, int val) {
    heap->data[heap->size] = val;
    int i = heap->size++;
    while (i && heap->data[i] < heap->data[(i - 1) / 2]) {
        swap(&heap->data[i], &heap->data[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int extractMin(MinHeap *heap) {
    if (heap->size == 0)
        return -1;
    int root = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    minHeapify(heap, 0);
    return root;
}

int isAboveThreshold(int *parent, int *weight, int n, int u, int v, int threshold) {
    while (u != v) {
        if (weight[u] < threshold) return 0;
        u = parent[u];
    }
    return 1;
}

int* minEdgeWeightEquilibriumQueries(int n, int** edges, int edgesSize, int** queries, int queriesSize, int* returnSize) {
    int *parent = (int *)malloc(n * sizeof(int));
    int *weight = (int *)malloc(n * sizeof(int));
    int *result = (int *)malloc(queriesSize * sizeof(int));

    MinHeap *heap = createMinHeap(n);
    for (int i = 0; i < edgesSize; i++) {
        insertMinHeap(heap, edges[i][2]);
        parent[edges[i][0]] = edges[i][1];
        weight[edges[i][0]] = edges[i][2];
    }

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        int threshold = queries[i][2];
        result[i] = isAboveThreshold(parent, weight, n, u, v, threshold);
    }

    free(parent);
    free(weight);
    free(heap->data);
    free(heap);
    *returnSize = queriesSize;
    return result;
}