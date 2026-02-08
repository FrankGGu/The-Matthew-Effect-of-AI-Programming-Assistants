#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTime(int n, int** edges, int edgesSize, int* edgesColSize, bool* hasApple, int hasAppleSize) {
    int *degree = (int *)calloc(n, sizeof(int));
    int **adj = (int **)malloc(n * sizeof(int *));
    int *adjSize = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        adj[i] = (int *)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
        degree[u]++;
        degree[v]++;
    }

    bool *visited = (bool *)calloc(n, sizeof(bool));
    int time = 0;

    int dfs(int u, int parent) {
        visited[u] = true;
        int childNeed = 0;
        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];
            if (v != parent) {
                int need = dfs(v, u);
                if (need > 0 || hasApple[v]) {
                    childNeed += 2 + need;
                }
            }
        }
        return childNeed;
    }

    time = dfs(0, -1);

    free(degree);
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSize);
    free(visited);

    return time;
}