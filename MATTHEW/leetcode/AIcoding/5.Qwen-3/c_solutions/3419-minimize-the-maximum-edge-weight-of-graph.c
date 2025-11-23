#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int find(int *parent, int x) {
    if (parent[x] != x)
        parent[x] = find(parent, parent[x]);
    return parent[x];
}

void unionSet(int *parent, int *rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY])
            parent[rootY] = rootX;
        else {
            parent[rootX] = rootY;
            if (rank[rootX] == rank[rootY])
                rank[rootY]++;
        }
    }
}

int* minEdgeToMakeConnected(int** edges, int edgesSize, int* edgesColSize, int n, int* returnSize) {
    int* result = (int*)malloc(sizeof(int));
    *returnSize = 1;
    result[0] = -1;

    if (edgesSize == 0) {
        return result;
    }

    int** sortedEdges = (int**)malloc(edgesSize * sizeof(int*));
    for (int i = 0; i < edgesSize; i++) {
        sortedEdges[i] = (int*)malloc(3 * sizeof(int));
        sortedEdges[i][0] = edges[i][0];
        sortedEdges[i][1] = edges[i][1];
        sortedEdges[i][2] = edges[i][2];
    }

    qsort(sortedEdges, edgesSize, sizeof(int*), compare);

    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int components = n;
    int minEdge = -1;

    for (int i = 0; i < edgesSize; i++) {
        int u = sortedEdges[i][0];
        int v = sortedEdges[i][1];
        int w = sortedEdges[i][2];

        if (find(parent, u) != find(parent, v)) {
            unionSet(parent, rank, u, v);
            components--;
            minEdge = w;
        }
    }

    if (components == 1) {
        result[0] = minEdge;
    } else {
        result[0] = -1;
    }

    for (int i = 0; i < edgesSize; i++) {
        free(sortedEdges[i]);
    }
    free(sortedEdges);
    free(parent);
    free(rank);

    return result;
}