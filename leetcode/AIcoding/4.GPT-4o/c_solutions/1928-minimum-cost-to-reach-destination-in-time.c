#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    long long cost;
} Node;

typedef struct {
    Node* nodes;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->nodes = (Node*)malloc(capacity * sizeof(Node));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    return minHeap;
}

void swap(Node* a, Node* b) {
    Node temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap* minHeap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < minHeap->size && minHeap->nodes[left].cost < minHeap->nodes[smallest].cost)
        smallest = left;
    if (right < minHeap->size && minHeap->nodes[right].cost < minHeap->nodes[smallest].cost)
        smallest = right;
    if (smallest != idx) {
        swap(&minHeap->nodes[smallest], &minHeap->nodes[idx]);
        minHeapify(minHeap, smallest);
    }
}

void insertMinHeap(MinHeap* minHeap, Node node) {
    if (minHeap->size == minHeap->capacity) return;
    minHeap->nodes[minHeap->size] = node;
    int i = minHeap->size;
    minHeap->size++;

    while (i != 0 && minHeap->nodes[(i - 1) / 2].cost > minHeap->nodes[i].cost) {
        swap(&minHeap->nodes[i], &minHeap->nodes[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

Node extractMin(MinHeap* minHeap) {
    Node root = minHeap->nodes[0];
    minHeap->nodes[0] = minHeap->nodes[minHeap->size - 1];
    minHeap->size--;
    minHeapify(minHeap, 0);
    return root;
}

void freeMinHeap(MinHeap* minHeap) {
    free(minHeap->nodes);
    free(minHeap);
}

long long minimumCost(int n, int** edges, int edgesSize, int* edgesColSize, int timeLimit) {
    long long* costs = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) costs[i] = LLONG_MAX;
    costs[0] = 0;

    MinHeap* minHeap = createMinHeap(n);
    insertMinHeap(minHeap, (Node){0, 0});

    while (minHeap->size > 0) {
        Node current = extractMin(minHeap);
        int u = current.node;

        for (int i = 0; i < edgesSize; i++) {
            if (edges[i][0] == u) {
                int v = edges[i][1];
                long long newCost = costs[u] + edges[i][2];
                if (newCost < costs[v]) {
                    costs[v] = newCost;
                    insertMinHeap(minHeap, (Node){v, newCost});
                }
            }
        }
    }

    freeMinHeap(minHeap);
    long long result = costs[n - 1];
    free(costs);
    return result <= timeLimit ? result : -1;
}