#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    int idx;
} Pair;

int compare(const void* a, const void* b) {
    return ((Pair*)a)->val - ((Pair*)b)->val;
}

int** buildMatrix(int n, int k, int** conditions, int conditionsSize, int* conditionsColSize, int* returnSize, int** returnColumnSizes) {
    int** matrix = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }
    *returnSize = n;

    int* indegree = (int*)calloc(n, sizeof(int));
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i < conditionsSize; i++) {
        int u = conditions[i][0] - 1;
        int v = conditions[i][1] - 1;
        adj[u][v] = 1;
        indegree[v]++;
    }

    Pair* nodes = (Pair*)malloc(n * sizeof(Pair));
    for (int i = 0; i < n; i++) {
        nodes[i].val = indegree[i];
        nodes[i].idx = i;
    }
    qsort(nodes, n, sizeof(Pair), compare);

    int* order = (int*)malloc(n * sizeof(int));
    int ptr = 0;

    for (int i = 0; i < n; i++) {
        order[ptr++] = nodes[i].idx;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (adj[order[i]][order[j]] == 1) {
                matrix[i][j] = 1;
            } else {
                matrix[i][j] = 0;
            }
        }
    }

    free(nodes);
    free(indegree);
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(order);

    return matrix;
}