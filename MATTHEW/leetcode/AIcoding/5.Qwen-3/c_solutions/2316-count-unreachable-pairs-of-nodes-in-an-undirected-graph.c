#include <stdio.h>
#include <stdlib.h>

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

long long countUnreachablePairs(int n, int** edges, int edgesSize, int* edgesColSize) {
    UnionFind* uf = createUnionFind(n);
    for (int i = 0; i < edgesSize; i++) {
        unionSet(uf, edges[i][0], edges[i][1]);
    }

    int* componentSize = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        componentSize[root]++;
    }

    long long total = 0;
    long long sum = 0;
    for (int i = 0; i < n; i++) {
        if (componentSize[i] > 0) {
            total += (long long)componentSize[i] * sum;
            sum += componentSize[i];
        }
    }

    free(componentSize);
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return total;
}