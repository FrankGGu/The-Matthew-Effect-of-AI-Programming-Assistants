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

void union_sets(int *parent, int *rank, int x, int y) {
    x = find(parent, x);
    y = find(parent, y);
    if (x != y) {
        if (rank[x] < rank[y]) {
            parent[x] = y;
        } else if (rank[x] > rank[y]) {
            parent[y] = x;
        } else {
            parent[y] = x;
            rank[x]++;
        }
    }
}

int* findEdgesInShortestPaths(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int totalEdges = edgesSize;
    Edge *edgeList = (Edge *)malloc(totalEdges * sizeof(Edge));
    for (int i = 0; i < totalEdges; i++) {
        edgeList[i].u = edges[i][0] - 1;
        edgeList[i].v = edges[i][1] - 1;
        edgeList[i].w = edges[i][2];
    }

    qsort(edgeList, totalEdges, sizeof(Edge), cmp);

    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    int *result = (int *)malloc(totalEdges * sizeof(int));
    memset(result, 0, totalEdges * sizeof(int));

    int *dist = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[0] = 0;

    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < totalEdges; j++) {
            int u = edgeList[j].u;
            int v = edgeList[j].v;
            int w = edgeList[j].w;
            if (dist[u] != INT_MAX && dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
                union_sets(parent, rank, u, v);
            }
        }
    }

    for (int i = 0; i < totalEdges; i++) {
        int u = edgeList[i].u;
        int v = edgeList[i].v;
        if (find(parent, u) == find(parent, v) && dist[u] + edgeList[i].w == dist[v]) {
            result[i] = 1;
        }
    }

    *returnSize = totalEdges;
    free(edgeList);
    free(parent);
    free(rank);
    free(dist);
    return result;
}