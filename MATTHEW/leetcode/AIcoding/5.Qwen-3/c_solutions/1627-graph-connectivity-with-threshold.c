#include <stdio.h>
#include <stdlib.h>

typedef struct UnionFind {
    int *parent;
    int *rank;
    int size;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind *uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->size = n;
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
    }
    return uf;
}

int find(UnionFind *uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSet(UnionFind *uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else {
            uf->parent[rootX] = rootY;
            if (uf->rank[rootX] == uf->rank[rootY]) {
                uf->rank[rootY]++;
            }
        }
    }
}

void freeUnionFind(UnionFind *uf) {
    free(uf->parent);
    free(uf->rank);
    free(uf);
}

bool areConnected(UnionFind *uf, int x, int y) {
    return find(uf, x) == find(uf, y);
}

bool *areConnectedAfterOperations(int n, int** queries, int queriesSize, int* queriesColSize, int threshold, int* returnSize) {
    UnionFind *uf = createUnionFind(n + 1);
    for (int i = threshold + 1; i <= n; i++) {
        for (int j = i; j <= n; j += i) {
            unionSet(uf, i, j);
        }
    }
    bool *result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        result[i] = areConnected(uf, u, v);
    }
    *returnSize = queriesSize;
    freeUnionFind(uf);
    return result;
}