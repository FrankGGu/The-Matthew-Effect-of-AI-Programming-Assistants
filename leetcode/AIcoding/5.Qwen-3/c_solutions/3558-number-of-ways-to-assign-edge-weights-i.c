#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int u;
    int v;
} Edge;

int cmp(const void* a, const void* b) {
    Edge* x = (Edge*)a;
    Edge* y = (Edge*)b;
    if (x->u != y->u) return x->u - y->u;
    return x->v - y->v;
}

long long countWays(int n, int** edges, int edgesSize, int* edgesColSize) {
    int m = edgesSize;
    Edge* edgeList = (Edge*)malloc(m * sizeof(Edge));
    for (int i = 0; i < m; i++) {
        edgeList[i].u = edges[i][0];
        edgeList[i].v = edges[i][1];
    }
    qsort(edgeList, m, sizeof(Edge), cmp);

    int* parent = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) parent[i] = i;

    int find(int x) {
        while (parent[x] != x) {
            parent[x] = parent[parent[x]];
            x = parent[x];
        }
        return x;
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) parent[rootY] = rootX;
    }

    for (int i = 0; i < m; i++) {
        unionSet(edgeList[i].u, edgeList[i].v);
    }

    int* rootCount = (int*)calloc(n + 1, sizeof(int));
    for (int i = 1; i <= n; i++) {
        rootCount[find(i)]++;
    }

    long long result = 1;
    for (int i = 1; i <= n; i++) {
        if (rootCount[i] > 0) {
            result = result * (rootCount[i] - 1) % 1000000007;
        }
    }

    free(edgeList);
    free(parent);
    free(rootCount);
    return result;
}