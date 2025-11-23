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

int regionsBySlashes(char** grid, int gridSize) {
    int n = gridSize;
    int size = n * n * 4;
    UnionFind* uf = createUnionFind(size);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int base = (i * n + j) * 4;
            char c = grid[i][j];
            if (c == '/') {
                unionSet(uf, base + 0, base + 3);
                unionSet(uf, base + 1, base + 2);
            } else if (c == '\\') {
                unionSet(uf, base + 0, base + 1);
                unionSet(uf, base + 2, base + 3);
            } else {
                unionSet(uf, base + 0, base + 1);
                unionSet(uf, base + 1, base + 2);
                unionSet(uf, base + 2, base + 3);
            }

            if (i > 0) {
                int upBase = ((i - 1) * n + j) * 4;
                unionSet(uf, base + 0, upBase + 2);
            }
            if (j > 0) {
                int leftBase = (i * n + (j - 1)) * 4;
                unionSet(uf, base + 1, leftBase + 3);
            }
        }
    }

    int unique = 0;
    int* roots = (int*)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        roots[find(uf, i)] = 1;
    }

    for (int i = 0; i < size; i++) {
        if (roots[i]) {
            unique++;
        }
    }

    free(uf->parent);
    free(uf->rank);
    free(uf);
    free(roots);
    return unique;
}