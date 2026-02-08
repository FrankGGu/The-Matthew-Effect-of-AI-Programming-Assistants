#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    int distance;
} Pair;

typedef struct {
    int* data;
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

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(Heap* heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap->data[index] >= heap->data[parent]) break;
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
    }
}

void heapifyDown(Heap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left] < heap->data[smallest])
        smallest = left;
    if (right < heap->size && heap->data[right] < heap->data[smallest])
        smallest = right;

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insert(Heap* heap, int value) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (int*)realloc(heap->data, heap->capacity * sizeof(int));
    }
    heap->data[heap->size++] = value;
    heapifyUp(heap, heap->size - 1);
}

int extractMin(Heap* heap) {
    if (heap->size == 0) return -1;
    int min = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    heapifyDown(heap, 0);
    return min;
}

void freeHeap(Heap* heap) {
    free(heap->data);
    free(heap);
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int numberOfWays(int n, int** roads) {
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        int time = roads[i][2];
        graph[u][v] += time;
        graph[v][u] += time;
    }

    int* dist = (int*)malloc(n * sizeof(int));
    int* ways = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
        ways[i] = 0;
    }

    dist[0] = 0;
    ways[0] = 1;

    Heap* heap = createHeap(n);
    insert(heap, 0);

    while (heap->size > 0) {
        int u = extractMin(heap);
        for (int v = 0; v < n; v++) {
            if (graph[u][v] > 0) {
                if (dist[v] > dist[u] + graph[u][v]) {
                    dist[v] = dist[u] + graph[u][v];
                    ways[v] = ways[u];
                    insert(heap, v);
                } else if (dist[v] == dist[u] + graph[u][v]) {
                    ways[v] = (ways[v] + ways[u]) % 1000000007;
                }
            }
        }
    }

    int result = ways[n - 1];
    free(dist);
    free(ways);
    for (int i = 0; i < n; i++) free(graph[i]);
    free(graph);
    freeHeap(heap);
    return result;
}