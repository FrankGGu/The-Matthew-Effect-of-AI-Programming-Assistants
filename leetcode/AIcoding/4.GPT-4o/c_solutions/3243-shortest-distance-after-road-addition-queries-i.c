#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int u, v, w;
} Edge;

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int *parent, int *rank, int x, int y) {
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

int *shortestDistance(int n, int **roads, int roadsSize, int *roadsColSize, int **queries, int queriesSize, int *returnSize) {
    int *res = (int *)malloc(queriesSize * sizeof(int));
    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    Edge *edges = (Edge *)malloc(roadsSize * sizeof(Edge));
    for (int i = 0; i < roadsSize; i++) {
        edges[i].u = roads[i][0];
        edges[i].v = roads[i][1];
        edges[i].w = roads[i][2];
    }

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        int minDist = INT_MAX;

        for (int j = 0; j < roadsSize; j++) {
            unionSets(parent, rank, edges[j].u, edges[j].v);
        }

        for (int j = 0; j < roadsSize; j++) {
            if (find(parent, u) == find(parent, v)) {
                minDist = 0;
            }
        }

        res[i] = (minDist == INT_MAX) ? -1 : minDist;
    }

    *returnSize = queriesSize;
    free(parent);
    free(rank);
    free(edges);
    return res;
}