#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int n;
    int **adjMatrix;
} Graph;

Graph* graphCreate(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->n = n;
    graph->adjMatrix = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph->adjMatrix[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            if (i == j) {
                graph->adjMatrix[i][j] = 0;
            } else {
                graph->adjMatrix[i][j] = INT_MAX;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        graph->adjMatrix[edges[i][0]][edges[i][1]] = edges[i][2];
    }

    return graph;
}

void graphAddEdge(Graph* obj, int u, int v, int cost) {
    obj->adjMatrix[u][v] = cost;
}

int graphShortestPath(Graph* obj, int node1, int node2) {
    int n = obj->n;
    int dist[n];
    int visited[n];

    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
        visited[i] = 0;
    }

    dist[node1] = 0;

    for (int count = 0; count < n - 1; count++) {
        int u = -1;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && (u == -1 || dist[v] < dist[u])) {
                u = v;
            }
        }

        if (u == -1) break;

        visited[u] = 1;

        for (int v = 0; v < n; v++) {
            if (!visited[v] && obj->adjMatrix[u][v] != INT_MAX && dist[u] != INT_MAX && dist[u] + obj->adjMatrix[u][v] < dist[v]) {
                dist[v] = dist[u] + obj->adjMatrix[u][v];
            }
        }
    }

    if (dist[node2] == INT_MAX) {
        return -1;
    } else {
        return dist[node2];
    }
}

void graphFree(Graph* obj) {
    for (int i = 0; i < obj->n; i++) {
        free(obj->adjMatrix[i]);
    }
    free(obj->adjMatrix);
    free(obj);
}