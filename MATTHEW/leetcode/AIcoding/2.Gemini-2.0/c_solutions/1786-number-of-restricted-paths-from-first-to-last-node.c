#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef struct Edge {
    int to;
    int weight;
} Edge;

typedef struct Node {
    int vertex;
    int distance;
} Node;

typedef struct MinHeap {
    int capacity;
    int size;
    Node* array;
    int* pos;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->capacity = capacity;
    minHeap->size = 0;
    minHeap->array = (Node*)malloc(capacity * sizeof(Node));
    minHeap->pos = (int*)malloc(capacity * sizeof(int));
    return minHeap;
}

void swapMinHeapNode(Node* a, Node* b) {
    Node t = *a;
    *a = *b;
    *b = t;
}

void minHeapify(MinHeap* minHeap, int idx) {
    int smallest, left, right;
    smallest = idx;
    left = 2 * idx + 1;
    right = 2 * idx + 2;

    if (left < minHeap->size && minHeap->array[left].distance < minHeap->array[smallest].distance)
        smallest = left;

    if (right < minHeap->size && minHeap->array[right].distance < minHeap->array[smallest].distance)
        smallest = right;

    if (smallest != idx) {
        Node smallestNode = minHeap->array[smallest];
        Node idxNode = minHeap->array[idx];

        minHeap->pos[smallestNode.vertex] = idx;
        minHeap->pos[idxNode.vertex] = smallest;

        swapMinHeapNode(&minHeap->array[smallest], &minHeap->array[idx]);

        minHeapify(minHeap, smallest);
    }
}

int isEmpty(MinHeap* minHeap) {
    return minHeap->size == 0;
}

Node extractMin(MinHeap* minHeap) {
    if (isEmpty(minHeap)) {
        Node empty = {-1, INT_MAX};
        return empty;
    }

    Node root = minHeap->array[0];
    Node lastNode = minHeap->array[minHeap->size - 1];
    minHeap->array[0] = lastNode;

    minHeap->pos[root.vertex] = minHeap->size - 1;
    minHeap->pos[lastNode.vertex] = 0;

    --minHeap->size;
    minHeapify(minHeap, 0);

    return root;
}

void decreaseKey(MinHeap* minHeap, int v, int dist) {
    int i = minHeap->pos[v];

    minHeap->array[i].distance = dist;

    while (i > 0 && minHeap->array[i].distance < minHeap->array[(i - 1) / 2].distance) {
        minHeap->pos[minHeap->array[i].vertex] = (i - 1) / 2;
        minHeap->pos[minHeap->array[(i - 1) / 2].vertex] = i;
        swapMinHeapNode(&minHeap->array[i], &minHeap->array[(i - 1) / 2]);

        i = (i - 1) / 2;
    }
}

int countRestrictedPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    int adj[n + 1][n + 1];
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            adj[i][j] = INT_MAX;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        adj[u][v] = w;
        adj[v][u] = w;
    }

    int dist[n + 1];
    for (int i = 1; i <= n; i++) {
        dist[i] = INT_MAX;
    }
    dist[n] = 0;

    MinHeap* minHeap = createMinHeap(n + 1);
    for (int v = 1; v <= n; v++) {
        minHeap->array[v].vertex = v;
        minHeap->array[v].distance = dist[v];
        minHeap->pos[v] = v;
    }

    minHeap->size = n;
    decreaseKey(minHeap, n, 0);

    while (!isEmpty(minHeap)) {
        Node minNode = extractMin(minHeap);
        int u = minNode.vertex;

        for (int v = 1; v <= n; v++) {
            if (adj[u][v] != INT_MAX && minHeap->pos[v] < minHeap->size && dist[u] != INT_MAX && dist[u] + adj[u][v] < dist[v]) {
                dist[v] = dist[u] + adj[u][v];
                decreaseKey(minHeap, v, dist[v]);
            }
        }
    }

    int dp[n + 1];
    for (int i = 1; i <= n; i++) {
        dp[i] = 0;
    }
    dp[n] = 1;

    int visited[n + 1];
    for (int i = 1; i <= n; i++) {
        visited[i] = 0;
    }

    int stack[n + 1];
    int top = -1;

    stack[++top] = 1;
    visited[1] = 1;

    while (top >= 0) {
        int u = stack[top--];

        for (int v = 1; v <= n; v++) {
            if (adj[u][v] != INT_MAX && dist[u] > dist[v]) {
                if (dp[v] == 0 && visited[v] == 0) {
                    stack[++top] = v;
                    visited[v] = 1;
                }
                dp[u] = (dp[u] + dp[v]) % MOD;
            }
        }
    }
    return dp[1];
}