#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

struct Edge {
    int to, cost;
};

struct MinHeapNode {
    int v;
    int cost;
};

struct MinHeap {
    int size;
    int capacity;
    int *pos;
    struct MinHeapNode **array;
};

struct MinHeapNode* newMinHeapNode(int v, int cost) {
    struct MinHeapNode* minHeapNode = (struct MinHeapNode*)malloc(sizeof(struct MinHeapNode));
    minHeapNode->v = v;
    minHeapNode->cost = cost;
    return minHeapNode;
}

struct MinHeap* createMinHeap(int capacity) {
    struct MinHeap* minHeap = (struct MinHeap*)malloc(sizeof(struct MinHeap));
    minHeap->pos = (int*)malloc(capacity * sizeof(int));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    minHeap->array = (struct MinHeapNode**)malloc(capacity * sizeof(struct MinHeapNode*));
    return minHeap;
}

void swapMinHeapNode(struct MinHeapNode** a, struct MinHeapNode** b) {
    struct MinHeapNode* t = *a;
    *a = *b;
    *b = t;
}

void minHeapify(struct MinHeap* minHeap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < minHeap->size && minHeap->array[left]->cost < minHeap->array[smallest]->cost)
        smallest = left;

    if (right < minHeap->size && minHeap->array[right]->cost < minHeap->array[smallest]->cost)
        smallest = right;

    if (smallest != idx) {
        struct MinHeapNode* smallestNode = minHeap->array[smallest];
        struct MinHeapNode* idxNode = minHeap->array[idx];

        minHeap->pos[smallestNode->v] = idx;
        minHeap->pos[idxNode->v] = smallest;

        swapMinHeapNode(&minHeap->array[smallest], &minHeap->array[idx]);
        minHeapify(minHeap, smallest);
    }
}

int isEmpty(struct MinHeap* minHeap) {
    return minHeap->size == 0;
}

struct MinHeapNode* extractMin(struct MinHeap* minHeap) {
    if (isEmpty(minHeap))
        return NULL;

    struct MinHeapNode* root = minHeap->array[0];

    struct MinHeapNode* lastNode = minHeap->array[minHeap->size - 1];
    minHeap->array[0] = lastNode;

    minHeap->pos[root->v] = minHeap->size - 1;
    minHeap->pos[lastNode->v] = 0;

    --minHeap->size;
    minHeapify(minHeap, 0);

    return root;
}

void decreaseKey(struct MinHeap* minHeap, int v, int cost) {
    int i = minHeap->pos[v];
    minHeap->array[i]->cost = cost;

    while (i && minHeap->array[i]->cost < minHeap->array[(i - 1) / 2]->cost) {
        minHeap->pos[minHeap->array[i]->v] = (i - 1) / 2;
        minHeap->pos[minHeap->array[(i - 1) / 2]->v] = i;
        swapMinHeapNode(&minHeap->array[i], &minHeap->array[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int isInMinHeap(struct MinHeap* minHeap, int v) {
    return minHeap->pos[v] < minHeap->size;
}

int minCost(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* dist = (int*)malloc(n * sizeof(int));
    struct Edge** graph = (struct Edge**)malloc(n * sizeof(struct Edge*));
    int* edgeCount = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        edgeCount[edges[i][0]]++;
    }

    for (int i = 0; i < n; i++) {
        graph[i] = (struct Edge*)malloc(edgeCount[i] * sizeof(struct Edge));
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][--edgeCount[edges[i][0]]] = (struct Edge){edges[i][1], edges[i][2]};
    }

    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[0] = 0;

    struct MinHeap* minHeap = createMinHeap(n);
    for (int v = 0; v < n; ++v) {
        minHeap->array[v] = newMinHeapNode(v, dist[v]);
        minHeap->pos[v] = v;
    }
    minHeap->size = n;

    while (!isEmpty(minHeap)) {
        struct MinHeapNode* minNode = extractMin(minHeap);
        int u = minNode->v;

        for (int i = 0; i < edgeCount[u]; i++) {
            int v = graph[u][i].to;
            int weight = graph[u][i].cost;

            if (isInMinHeap(minHeap, v) && dist[u] != INT_MAX && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                decreaseKey(minHeap, v, dist[v]);
            }
        }
    }

    int result = dist[n - 1];
    free(dist);
    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(edgeCount);
    free(minHeap->pos);
    free(minHeap->array);
    free(minHeap);

    return result == INT_MAX ? -1 : result;
}