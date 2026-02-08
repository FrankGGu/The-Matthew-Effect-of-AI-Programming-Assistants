#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* loudAndRich(int** richer, int richerSize, int* richerColSize, int* quiet, int quietSize, int* returnSize) {
    int n = quietSize;
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(0);
    }

    int* inDegree = (int*)malloc(n * sizeof(int));
    memset(inDegree, 0, n * sizeof(int));

    for (int i = 0; i < richerSize; i++) {
        int u = richer[i][1];
        int v = richer[i][0];
        graph[u] = (int*)realloc(graph[u], (inDegree[u] + 1) * sizeof(int));
        graph[u][inDegree[u]++] = v;
    }

    int* result = (int*)malloc(n * sizeof(int));
    int* visited = (int*)malloc(n * sizeof(int));
    int* stack = (int*)malloc(n * sizeof(int));
    int top = -1;

    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            stack[++top] = i;
        }
    }

    while (top >= 0) {
        int u = stack[top--];
        result[u] = u;
        for (int i = 0; i < inDegree[u]; i++) {
            int v = graph[u][i];
            if (quiet[result[v]] > quiet[result[u]]) {
                result[v] = result[u];
            }
            inDegree[v]--;
            if (inDegree[v] == 0) {
                stack[++top] = v;
            }
        }
    }

    *returnSize = n;
    free(visited);
    free(stack);
    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(inDegree);
    return result;
}