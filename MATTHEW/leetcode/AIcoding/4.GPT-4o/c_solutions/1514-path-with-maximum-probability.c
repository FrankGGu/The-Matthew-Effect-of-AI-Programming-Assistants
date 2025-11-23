#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <float.h>

typedef struct {
    int node;
    double prob;
} Edge;

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

MaxHeap* createMaxHeap(int capacity) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void maxHeapInsert(MaxHeap* heap, int node) {
    heap->data[heap->size++] = node;
    int i = heap->size - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->data[parent] >= heap->data[i]) break;
        int temp = heap->data[parent];
        heap->data[parent] = heap->data[i];
        heap->data[i] = temp;
        i = parent;
    }
}

int maxHeapExtractMax(MaxHeap* heap) {
    if (heap->size == 0) return -1;
    int maxNode = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    int i = 0;
    while (1) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        if (left >= heap->size) break;
        int maxChild = left;
        if (right < heap->size && heap->data[right] > heap->data[left]) {
            maxChild = right;
        }
        if (heap->data[i] >= heap->data[maxChild]) break;
        int temp = heap->data[i];
        heap->data[i] = heap->data[maxChild];
        heap->data[maxChild] = temp;
        i = maxChild;
    }
    return maxNode;
}

double maxProbability(int n, int** edges, int edgesSize, int* edgesColSize, int start, int end) {
    double* probabilities = (double*)malloc(n * sizeof(double));
    int* visited = (int*)calloc(n, sizeof(int));
    Edge* adjList = (Edge*)malloc(n * sizeof(Edge));
    for (int i = 0; i < n; i++) {
        adjList[i].node = i;
        adjList[i].prob = 0.0;
    }
    for (int i = 0; i < edgesSize; i++) {
        adjList[edges[i][0]].prob = fmax(adjList[edges[i][0]].prob, (double)edges[i][1]);
        adjList[edges[i][1]].prob = fmax(adjList[edges[i][1]].prob, (double)edges[i][0]);
    }
    probabilities[start] = 1.0;
    MaxHeap* heap = createMaxHeap(n);
    maxHeapInsert(heap, start);
    while (heap->size > 0) {
        int curr = maxHeapExtractMax(heap);
        if (curr == end) {
            free(probabilities);
            free(visited);
            free(adjList);
            return probabilities[end];
        }
        visited[curr] = 1;
        for (int i = 0; i < edgesSize; i++) {
            if (edges[i][0] == curr && !visited[edges[i][1]]) {
                double newProb = probabilities[curr] * edges[i][1];
                if (newProb > probabilities[edges[i][1]]) {
                    probabilities[edges[i][1]] = newProb;
                    maxHeapInsert(heap, edges[i][1]);
                }
            }
            if (edges[i][1] == curr && !visited[edges[i][0]]) {
                double newProb = probabilities[curr] * edges[i][1];
                if (newProb > probabilities[edges[i][0]]) {
                    probabilities[edges[i][0]] = newProb;
                    maxHeapInsert(heap, edges[i][0]);
                }
            }
        }
    }
    free(probabilities);
    free(visited);
    free(adjList);
    return 0.0;
}