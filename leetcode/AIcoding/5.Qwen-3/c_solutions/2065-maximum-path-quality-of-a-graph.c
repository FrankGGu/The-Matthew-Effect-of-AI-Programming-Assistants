#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* neighbors;
    int size;
} AdjList;

int maxQuality = 0;

void dfs(int node, int* visited, int* values, int* pathQuality, int start, int end, int k, AdjList* adj) {
    if (node == end) {
        if (*pathQuality >= k) {
            maxQuality++;
        }
        return;
    }

    for (int i = 0; i < adj[node].size; i++) {
        int neighbor = adj[node].neighbors[i];
        if (!visited[neighbor]) {
            visited[neighbor] = 1;
            *pathQuality += values[neighbor];
            dfs(neighbor, visited, values, pathQuality, start, end, k, adj);
            *pathQuality -= values[neighbor];
            visited[neighbor] = 0;
        }
    }
}

int maxPathQuality(int n, int** roads, int roadsSize, int* values, int valuesSize, int start, int end, int k) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].size = 0;
        adj[i].neighbors = NULL;
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        int* temp = (int*)realloc(adj[u].neighbors, (adj[u].size + 1) * sizeof(int));
        temp[adj[u].size++] = v;
        adj[u].neighbors = temp;

        temp = (int*)realloc(adj[v].neighbors, (adj[v].size + 1) * sizeof(int));
        temp[adj[v].size++] = u;
        adj[v].neighbors = temp;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int pathQuality = values[start];
    visited[start] = 1;

    maxQuality = 0;
    dfs(start, visited, values, &pathQuality, start, end, k, adj);

    for (int i = 0; i < n; i++) {
        free(adj[i].neighbors);
    }
    free(adj);
    free(visited);

    return maxQuality;
}