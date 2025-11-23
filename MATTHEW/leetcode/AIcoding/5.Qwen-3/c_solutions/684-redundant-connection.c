#include <stdio.h>
#include <stdlib.h>

int* findRedundantConnection(int** edges, int edgesSize, int* returnSize) {
    int* parent = (int*)malloc(sizeof(int) * (edgesSize + 1));

    for (int i = 0; i <= edgesSize; i++) {
        parent[i] = i;
    }

    int* result = (int*)malloc(sizeof(int) * 2);

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        int rootU = u;
        while (parent[rootU] != rootU) {
            rootU = parent[rootU];
        }

        int rootV = v;
        while (parent[rootV] != rootV) {
            rootV = parent[rootV];
        }

        if (rootU == rootV) {
            result[0] = u;
            result[1] = v;
            *returnSize = 2;
            free(parent);
            return result;
        } else {
            parent[rootV] = rootU;
        }
    }

    free(parent);
    *returnSize = 0;
    return NULL;
}