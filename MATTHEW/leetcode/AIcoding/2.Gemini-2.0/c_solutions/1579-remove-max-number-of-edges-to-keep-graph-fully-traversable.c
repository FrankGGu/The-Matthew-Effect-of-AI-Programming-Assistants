#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *parent;
    int *rank;
    int count;
} UnionFind;

UnionFind* uf_init(int n) {
    UnionFind *uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(sizeof(int) * (n + 1));
    uf->rank = (int*)malloc(sizeof(int) * (n + 1));
    uf->count = n;
    for (int i = 0; i <= n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 0;
    }
    return uf;
}

int uf_find(UnionFind *uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = uf_find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

int uf_union(UnionFind *uf, int x, int y) {
    int rootX = uf_find(uf, x);
    int rootY = uf_find(uf, y);
    if (rootX == rootY) {
        return 0;
    }
    if (uf->rank[rootX] < uf->rank[rootY]) {
        uf->parent[rootX] = rootY;
    } else if (uf->rank[rootX] > uf->rank[rootY]) {
        uf->parent[rootY] = rootX;
    } else {
        uf->parent[rootY] = rootX;
        uf->rank[rootX]++;
    }
    uf->count--;
    return 1;
}

void uf_free(UnionFind *uf) {
    free(uf->parent);
    free(uf->rank);
    free(uf);
}

int maxNumEdgesToRemove(int n, int** edges, int edgesSize, int* edgesColSize){
    UnionFind *uf_a = uf_init(n);
    UnionFind *uf_b = uf_init(n);
    int removed_edges = 0;

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == 3) {
            if (uf_union(uf_a, edges[i][1], edges[i][2])) {
                uf_union(uf_b, edges[i][1], edges[i][2]);
            } else {
                removed_edges++;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == 1) {
            if (!uf_union(uf_a, edges[i][1], edges[i][2])) {
                removed_edges++;
            }
        } else if (edges[i][0] == 2) {
            if (!uf_union(uf_b, edges[i][1], edges[i][2])) {
                removed_edges++;
            }
        }
    }

    if (uf_a->count != 1 || uf_b->count != 1) {
        removed_edges = -1;
    }

    uf_free(uf_a);
    uf_free(uf_b);

    return removed_edges;
}