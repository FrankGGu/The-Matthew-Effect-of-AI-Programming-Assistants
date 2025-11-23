#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 100

int* color;

int dfs(int** graph, int graphSize, int* graphColSize, int node, int c) {
    if (color[node] != -1) {
        return color[node] == c;
    }
    color[node] = c;
    for (int i = 0; i < graphColSize[node]; i++) {
        int neighbor = graph[node][i];
        if (!dfs(graph, graphSize, graphColSize, neighbor, 1 - c)) {
            return 0;
        }
    }
    return 1;
}

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    color = (int*)malloc(graphSize * sizeof(int));
    for (int i = 0; i < graphSize; i++) {
        color[i] = -1;
    }
    for (int i = 0; i < graphSize; i++) {
        if (color[i] == -1 && !dfs(graph, graphSize, graphColSize, i, 0)) {
            free(color);
            return false;
        }
    }
    free(color);
    return true;
}