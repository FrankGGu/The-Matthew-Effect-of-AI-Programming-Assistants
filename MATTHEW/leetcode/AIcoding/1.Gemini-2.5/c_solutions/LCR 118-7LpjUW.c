#include <stdlib.h>

static int parent_arr[1001];

int find(int i) {
    if (parent_arr[i] == i) {
        return i;
    }
    return parent_arr[i] = find(parent_arr[i]);
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        parent_arr[root_i] = root_j;
    }
}

int* findRedundantConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = edgesSize;

    for (int i = 1; i <= n; i++) {
        parent_arr[i] = i;
    }

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        if (find(u) == find(v)) {
            result[0] = u;
            result[1] = v;
            return result;
        } else {
            unite(u, v);
        }
    }

    return NULL;
}