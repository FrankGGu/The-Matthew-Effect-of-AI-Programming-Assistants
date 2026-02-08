#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(int node, int* informTime, int** graph, int* visited) {
    if (visited[node]) return 0;
    visited[node] = 1;
    int maxTime = 0;
    for (int i = 0; graph[node][i] != -1; i++) {
        int child = graph[node][i];
        maxTime = max(maxTime, dfs(child, informTime, graph, visited) + informTime[node]);
    }
    return maxTime;
}

int numOfMinutes(int n, int headID, int* manager, int managerSize, int* informTime, int informTimeSize) {
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc((n + 1) * sizeof(int));
        int idx = 0;
        for (int j = 0; j < managerSize; j++) {
            if (manager[j] == i) {
                graph[i][idx++] = j;
            }
        }
        graph[i][idx] = -1;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int result = dfs(headID, informTime, graph, visited);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(visited);

    return result;
}