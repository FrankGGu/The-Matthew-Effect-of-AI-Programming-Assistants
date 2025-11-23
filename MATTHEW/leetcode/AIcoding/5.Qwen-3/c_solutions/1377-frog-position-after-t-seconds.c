#include <stdio.h>
#include <stdlib.h>

int* adjList;
int* visited;
int n;
int result;

void dfs(int node, int time, int parent, int t, int pos) {
    if (time == t) {
        result = node;
        return;
    }
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (adjList[node * n + i] && i != parent) {
            count++;
        }
    }
    if (count == 0) {
        result = node;
        return;
    }
    for (int i = 0; i < n; i++) {
        if (adjList[node * n + i] && i != parent) {
            visited[i] = 1;
            dfs(i, time + 1, node, t, pos);
            if (result != -1) return;
        }
    }
}

int frogPosition(int n, int** edges, int edgesSize, int* edgesColSize, int t, int target) {
    adjList = (int*)malloc(n * n * sizeof(int));
    for (int i = 0; i < n * n; i++) adjList[i] = 0;
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        adjList[u * n + v] = 1;
        adjList[v * n + u] = 1;
    }
    visited = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) visited[i] = 0;
    result = -1;
    visited[0] = 1;
    dfs(0, 0, -1, t, target);
    free(adjList);
    free(visited);
    return result;
}