#include <stdio.h>
#include <stdlib.h>

int find(int *parent, int x) {
    while (parent[x] != x) {
        parent[x] = parent[parent[x]];
        x = parent[x];
    }
    return x;
}

void unionSet(int *parent, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        parent[rootY] = rootX;
    }
}

int* findRedundantConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = edgesSize;
    int *parent = (int *)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        parent[i] = i;
    }

    int *result = (int *)malloc(2 * sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int x = edges[i][0];
        int y = edges[i][1];
        if (find(parent, x) == find(parent, y)) {
            result[0] = x;
            result[1] = y;
        } else {
            unionSet(parent, x, y);
        }
    }

    *returnSize = 2;
    return result;
}