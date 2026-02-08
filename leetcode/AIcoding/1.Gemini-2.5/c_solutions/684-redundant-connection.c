#include <stdlib.h>

int find_set(int* parent, int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find_set(parent, parent[i]);
}

int unite_sets(int* parent, int i, int j) {
    int root_i = find_set(parent, i);
    int root_j = find_set(parent, j);

    if (root_i != root_j) {
        parent[root_i] = root_j;
        return 1;
    }
    return 0;
}

int* findRedundantConnection(int** edges, int edgesSize, int* edgesColSize) {
    int N = edgesSize; 

    int* parent = (int*)malloc((N + 1) * sizeof(int));
    if (parent == NULL) {
        return NULL; 
    }

    for (int i = 1; i <= N; ++i) {
        parent[i] = i;
    }

    int* result = (int*)malloc(2 * sizeof(int));
    if (result == NULL) {
        free(parent);
        return NULL;
    }

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];

        if (unite_sets(parent, u, v) == 0) {
            result[0] = u;
            result[1] = v;
            free(parent);
            return result;
        }
    }

    free(parent);
    free(result);
    return NULL; 
}