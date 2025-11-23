#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* parent;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        uf->parent[rootY] = rootX;
    }
}

int* shortestDistanceAfterRoadAdditions(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    UnionFind* uf = createUnionFind(n);
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        unionSet(uf, u, v);
        int dist = 0;
        for (int j = 0; j < n; j++) {
            if (find(uf, j) != find(uf, j + 1)) {
                dist++;
            }
        }
        result[count++] = dist;
    }

    *returnSize = queriesSize;
    return result;
}