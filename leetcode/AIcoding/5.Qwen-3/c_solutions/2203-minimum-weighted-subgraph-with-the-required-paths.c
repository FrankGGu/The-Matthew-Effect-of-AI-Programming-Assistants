#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

typedef struct {
    Edge* head;
} AdjList;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void addEdge(AdjList* adj, int from, int to, int weight) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = to;
    newEdge->weight = weight;
    newEdge->next = adj[from].head;
    adj[from].head = newEdge;
}

void dijkstra(AdjList* adj, int n, int start, int* dist) {
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[start] = 0;

    int* visited = (int*)calloc(n, sizeof(int));
    int* heap = (int*)malloc(n * sizeof(int));
    int size = 0;

    heap[size++] = start;

    while (size > 0) {
        int u = heap[0];
        for (int i = 0; i < size - 1; i++) {
            heap[i] = heap[i + 1];
        }
        size--;

        if (visited[u]) continue;
        visited[u] = 1;

        Edge* e = adj[u].head;
        while (e) {
            int v = e->to;
            int w = e->weight;
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                int i = size;
                while (i > 0 && dist[heap[i - 1]] > dist[v]) {
                    heap[i] = heap[i - 1];
                    i--;
                }
                heap[i] = v;
                size++;
            }
            e = e->next;
        }
    }

    free(visited);
    free(heap);
}

int minWeightedSubgraph(int n, int** edges, int edgesSize, int* queries, int queriesSize) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].head = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        addEdge(adj, u, v, w);
        addEdge(adj, v, u, w);
    }

    int** dists = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dists[i] = (int*)malloc(n * sizeof(int));
        dijkstra(adj, n, i, dists[i]);
    }

    int total = 0;
    for (int i = 0; i < queriesSize; i++) {
        int q = queries[i];
        int sum = 0;
        for (int j = 0; j < n; j++) {
            sum += dists[j][q];
        }
        total += sum;
    }

    for (int i = 0; i < n; i++) {
        free(dists[i]);
    }
    free(dists);

    for (int i = 0; i < n; i++) {
        Edge* e = adj[i].head;
        while (e) {
            Edge* next = e->next;
            free(e);
            e = next;
        }
    }
    free(adj);

    return total;
}