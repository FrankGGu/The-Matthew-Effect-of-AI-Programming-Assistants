#include <stdlib.h>
#include <stdbool.h>

bool dfs(int u, int* states, int** graph, int* graphColSizes) {
    if (states[u] == 1) {
        states[u] = 3;
        return false;
    }
    if (states[u] == 2) {
        return true;
    }
    if (states[u] == 3) {
        return false;
    }

    states[u] = 1;

    for (int i = 0; i < graphColSizes[u]; i++) {
        int v = graph[u][i];
        if (!dfs(v, states, graph, graphColSizes)) {
            states[u] = 3;
            return false;
        }
    }

    states[u] = 2;
    return true;
}

int* eventualSafeNodes(int** graph, int graphSize, int* graphColSizes, int* returnSize) {
    int* states = (int*)calloc(graphSize, sizeof(int));

    int* result = (int*)malloc(graphSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < graphSize; i++) {
        if (dfs(i, states, graph, graphColSizes)) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    free(states);
    return result;
}