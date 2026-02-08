#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int** graph;
    int* visited;
    int n;
    int minCost;
} Solution;

void dfs(Solution* obj, int node, int cost, int pathSize, int* path) {
    if (pathSize == obj->n) {
        if (cost < obj->minCost) {
            obj->minCost = cost;
        }
        return;
    }

    for (int i = 0; i < obj->n; i++) {
        if (!obj->visited[i]) {
            obj->visited[i] = 1;
            path[pathSize] = i;
            dfs(obj, i, cost + obj->graph[node][i], pathSize + 1, path);
            obj->visited[i] = 0;
        }
    }
}

int findCheapestPrice(int n, int** flights, int flightsSize, int* flightsColSize, int src, int dst, int k) {
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < flightsSize; i++) {
        int u = flights[i][0];
        int v = flights[i][1];
        int price = flights[i][2];
        graph[u][v] = price;
    }

    int minCost = INT_MAX;
    int* visited = (int*)malloc(n * sizeof(int));
    int* path = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    visited[src] = 1;
    path[0] = src;

    dfs((Solution*)(&(struct { int** graph; int* visited; int n; int minCost; }){graph, visited, n, minCost}), src, 0, 1, path);

    free(visited);
    free(path);
    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);

    return minCost == INT_MAX ? -1 : minCost;
}