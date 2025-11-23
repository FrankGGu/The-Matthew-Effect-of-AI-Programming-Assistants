#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int parent;
    int rank;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(n * sizeof(UnionFind));
    for (int i = 0; i < n; i++) {
        uf[i].parent = i;
        uf[i].rank = 1;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf[x].parent != x) {
        uf[x].parent = find(uf, uf[x].parent);
    }
    return uf[x].parent;
}

int unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX == rootY) {
        return 0;
    }
    if (uf[rootX].rank > uf[rootY].rank) {
        uf[rootY].parent = rootX;
    } else {
        uf[rootX].parent = rootY;
        if (uf[rootX].rank == uf[rootY].rank) {
            uf[rootY].rank++;
        }
    }
    return 1;
}

int* findRedundantConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = edgesSize;
    UnionFind* uf = createUnionFind(n + 1);
    int* result = (int*)malloc(2 * sizeof(int));
    for (int i = 0; i < n; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (!unionSet(uf, u, v)) {
            result[0] = u;
            result[1] = v;
            *returnSize = 2;
            free(uf);
            return result;
        }
    }
    *returnSize = 0;
    free(uf);
    return NULL;
}