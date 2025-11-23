#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* edges;
    int size;
} AdjList;

void addEdge(AdjList* graph, int u, int v) {
    graph->edges[u] = v;
    graph->edges[v] = u;
}

int bfs(AdjList* graph, int start, int n) {
    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }
    dist[start] = 0;
    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = start;

    while (front < rear) {
        int u = queue[front++];
        for (int v = 0; v < n; v++) {
            if (graph->edges[u] == v && dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[rear++] = v;
            }
        }
    }

    int min_cycle = INT_MAX;
    for (int i = 0; i < n; i++) {
        if (dist[i] != -1) {
            for (int j = i + 1; j < n; j++) {
                if (graph->edges[i] == j && dist[j] != -1) {
                    min_cycle = (dist[i] + dist[j] + 1) < min_cycle ? (dist[i] + dist[j] + 1) : min_cycle;
                }
            }
        }
    }

    free(dist);
    free(queue);
    return min_cycle;
}

int findShortestCycle(int n, int** edges, int edgesSize, int* edgesColSize) {
    AdjList* graph = (AdjList*)malloc(sizeof(AdjList));
    graph->size = n;
    graph->edges = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph->edges[u] = v;
        graph->edges[v] = u;
    }

    int min_cycle = INT_MAX;
    for (int i = 0; i < n; i++) {
        int cycle = bfs(graph, i, n);
        if (cycle < min_cycle) {
            min_cycle = cycle;
        }
    }

    free(graph->edges);
    free(graph);
    return min_cycle;
}