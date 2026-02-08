#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* parent;
    int* rank;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
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

int* shortestDistanceAfterRoadAdditions(int n, int queries[], int queriesSize, int* returnSize) {
    UnionFind* uf = createUnionFind(n);
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int idx = 0;

    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i] / n;
        int b = queries[i] % n;
        unionSet(uf, a, b);
        int root = find(uf, 0);
        int distance = 0;
        for (int j = 1; j < n; j++) {
            if (find(uf, j) != root) {
                distance++;
            }
        }
        result[idx++] = distance;
    }

    *returnSize = idx;
    return result;
}