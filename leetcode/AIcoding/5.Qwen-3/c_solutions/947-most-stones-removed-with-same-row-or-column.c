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

int removeStones(int** stones, int stonesSize, int* stonesColSize) {
    UnionFind* uf = createUnionFind(stonesSize);
    for (int i = 0; i < stonesSize; i++) {
        int row = stones[i][0];
        int col = stones[i][1];
        for (int j = 0; j < stonesSize; j++) {
            if (i != j && (stones[i][0] == stones[j][0] || stones[i][1] == stones[j][1])) {
                unionSet(uf, i, j);
            }
        }
    }

    int uniqueRoots = 0;
    int* visited = (int*)calloc(stonesSize, sizeof(int));
    for (int i = 0; i < stonesSize; i++) {
        int root = find(uf, i);
        if (!visited[root]) {
            visited[root] = 1;
            uniqueRoots++;
        }
    }

    free(visited);
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return stonesSize - uniqueRoots;
}