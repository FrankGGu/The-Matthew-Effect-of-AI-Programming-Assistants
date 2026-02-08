#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    int u, v, w;
} Edge;

int cmp(const void *a, const void *b) {
    return ((Edge *)a)->w - ((Edge *)b)->w;
}

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int *parent, int *rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int minWeightedSubgraph(int n, int m, int** edges, int edgesSize, int* edgesColSize, int* sources, int sourcesSize, int* targets, int targetsSize) {
    Edge *edgeList = malloc(edgesSize * sizeof(Edge));
    for (int i = 0; i < edgesSize; i++) {
        edgeList[i] = (Edge){edges[i][0], edges[i][1], edges[i][2]};
    }

    qsort(edgeList, edgesSize, sizeof(Edge), cmp);

    int *parent = malloc((n + 1) * sizeof(int));
    int *rank = calloc(n + 1, sizeof(int));
    for (int i = 1; i <= n; i++) {
        parent[i] = i;
    }

    int totalWeight = 0;
    for (int i = 0; i < edgesSize; i++) {
        int u = edgeList[i].u;
        int v = edgeList[i].v;
        int w = edgeList[i].w;
        unionSet(parent, rank, u, v);
        if (find(parent, sources[0]) == find(parent, targets[0])) {
            totalWeight += w;
            break;
        }
    }

    free(edgeList);
    free(parent);
    free(rank);
    return totalWeight;
}