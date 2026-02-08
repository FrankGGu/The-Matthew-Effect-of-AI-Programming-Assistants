#include <stdio.h>
#include <stdlib.h>

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int* parent, int a, int b) {
    int rootA = find(parent, a);
    int rootB = find(parent, b);
    if (rootA != rootB) {
        parent[rootB] = rootA;
    }
}

int[] processRestrictions(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize, int* returnSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < restrictionsSize; i++) {
        unionSets(parent, restrictions[i][0], restrictions[i][1]);
    }

    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    for (int i = 0; i < n; i++) {
        result[i] = find(parent, i);
    }

    free(parent);
    return result;
}