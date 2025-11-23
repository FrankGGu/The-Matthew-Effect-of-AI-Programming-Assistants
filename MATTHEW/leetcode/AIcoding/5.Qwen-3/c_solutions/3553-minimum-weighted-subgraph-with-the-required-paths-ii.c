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

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

void addEdge(AdjList* adj, int from, int to, int weight) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = to;
    newEdge->weight = weight;
    newEdge->next = adj[from].head;
    adj[from].head = newEdge;
}

void dijkstra(AdjList* adj, int start, int n, int* dist) {
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[start] = 0;

    int* visited = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

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
            if (dist[e->to] > dist[u] + e->weight) {
                dist[e->to] = dist[u] + e->weight;
                int i = 0;
                while (i < size && heap[i] != e->to) {
                    i++;
                }
                if (i == size) {
                    heap[size++] = e->to;
                } else {
                    heap[i] = e->to;
                }
            }
            e = e->next;
        }
    }

    free(visited);
    free(heap);
}

int** getAdjList(int n, int** edges, int edgesSize, int* edgesColSize) {
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int from = edges[i][0];
        int to = edges[i][1];
        int weight = edges[i][2];
        adj[from][to] = weight;
    }

    return adj;
}

int minWeightedSubgraph(int n, int** edges, int edgesSize, int* edgesColSize, int* srcs, int srcsSize, int* dsts, int dstsSize) {
    int** adj = getAdjList(n, edges, edgesSize, edgesColSize);

    int* distFromSrcs = (int*)malloc(n * sizeof(int));
    int* distToDsts = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < srcsSize; i++) {
        int* tempDist = (int*)malloc(n * sizeof(int));
        dijkstra((AdjList*)adj, srcs[i], n, tempDist);
        for (int j = 0; j < n; j++) {
            if (distFromSrcs[j] == 0 || tempDist[j] < distFromSrcs[j]) {
                distFromSrcs[j] = tempDist[j];
            }
        }
        free(tempDist);
    }

    for (int i = 0; i < dstsSize; i++) {
        int* tempDist = (int*)malloc(n * sizeof(int));
        dijkstra((AdjList*)adj, dsts[i], n, tempDist);
        for (int j = 0; j < n; j++) {
            if (distToDsts[j] == 0 || tempDist[j] < distToDsts[j]) {
                distToDsts[j] = tempDist[j];
            }
        }
        free(tempDist);
    }

    int result = INT_MAX;
    for (int i = 0; i < n; i++) {
        if (distFromSrcs[i] != INT_MAX && distToDsts[i] != INT_MAX) {
            result = min(result, distFromSrcs[i] + distToDsts[i]);
        }
    }

    free(distFromSrcs);
    free(distToDsts);

    return result;
}