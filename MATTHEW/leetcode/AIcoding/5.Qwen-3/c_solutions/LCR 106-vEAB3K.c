#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100000

int* color;
int* visited;
int flag;

void dfs(int** graph, int graphSize, int* graphColSize, int node) {
    if (flag == 0) return;
    for (int i = 0; i < graphColSize[node]; i++) {
        int neighbor = graph[node][i];
        if (!visited[neighbor]) {
            visited[neighbor] = 1;
            color[neighbor] = 1 - color[node];
            dfs(graph, graphSize, graphColSize, neighbor);
        } else {
            if (color[neighbor] == color[node]) {
                flag = 0;
                return;
            }
        }
    }
}

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    color = (int*)malloc(graphSize * sizeof(int));
    visited = (int*)malloc(graphSize * sizeof(int));
    flag = 1;
    for (int i = 0; i < graphSize; i++) {
        color[i] = 0;
        visited[i] = 0;
    }
    for (int i = 0; i < graphSize; i++) {
        if (!visited[i]) {
            visited[i] = 1;
            color[i] = 0;
            dfs(graph, graphSize, graphColSize, i);
        }
    }
    free(color);
    free(visited);
    return flag;
}