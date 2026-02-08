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

int unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX == rootY) {
        return 0;
    }
    if (uf->rank[rootX] > uf->rank[rootY]) {
        uf->parent[rootY] = rootX;
    } else {
        uf->parent[rootX] = rootY;
        if (uf->rank[rootX] == uf->rank[rootY]) {
            uf->rank[rootY]++;
        }
    }
    return 1;
}

int removeMaxEdges(int n, int** edges, int edgesSize, int* edgesColSize) {
    UnionFind* uf1 = createUnionFind(n);
    UnionFind* uf2 = createUnionFind(n);

    int count = 0;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        int type = edges[i][2];

        if (type == 1) {
            if (unionSet(uf1, u, v)) {
                count++;
            }
        } else if (type == 2) {
            if (unionSet(uf2, u, v)) {
                count++;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        int type = edges[i][2];

        if (type == 1) {
            if (unionSet(uf2, u, v)) {
                count++;
            }
        } else if (type == 2) {
            if (unionSet(uf1, u, v)) {
                count++;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (find(uf1, i) != find(uf1, 0)) {
            return -1;
        }
        if (find(uf2, i) != find(uf2, 0)) {
            return -1;
        }
    }

    return edgesSize - count;
}

int getEdgesCount(int n, int** edges, int edgesSize, int* edgesColSize) {
    return removeMaxEdges(n, edges, edgesSize, edgesColSize);
}