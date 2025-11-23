#include <stdio.h>
#include <stdlib.h>

int* color;
int* visited;

int dfs(int u, int c, int** graph, int* graphSize, int* graphColSize) {
    if (visited[u]) {
        return color[u] == c;
    }
    visited[u] = 1;
    color[u] = c;
    for (int i = 0; i < graphColSize[u]; i++) {
        int v = graph[u][i];
        if (!dfs(v, 1 - c, graph, graphSize, graphColSize)) {
            return 0;
        }
    }
    return 1;
}

int possibleBipartition(int n, int** dislikes, int dislikesSize, int* dislikesColSize) {
    int** graph = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        graph[i] = (int*)malloc(0);
        graph[i][0] = 0;
    }

    for (int i = 0; i < dislikesSize; i++) {
        int u = dislikes[i][0];
        int v = dislikes[i][1];
        int* temp = (int*)realloc(graph[u], (graphColSize[u] + 1) * sizeof(int));
        temp[graphColSize[u]] = v;
        graph[u] = temp;
        graphColSize[u]++;

        temp = (int*)realloc(graph[v], (graphColSize[v] + 1) * sizeof(int));
        temp[graphColSize[v]] = u;
        graph[v] = temp;
        graphColSize[v]++;
    }

    color = (int*)malloc((n + 1) * sizeof(int));
    visited = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 1; i <= n; i++) {
        if (!visited[i] && !dfs(i, 0, graph, &n, graphColSize)) {
            for (int j = 0; j <= n; j++) {
                free(graph[j]);
            }
            free(graph);
            free(color);
            free(visited);
            return 0;
        }
    }

    for (int j = 0; j <= n; j++) {
        free(graph[j]);
    }
    free(graph);
    free(color);
    free(visited);
    return 1;
}