#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int u, v, w, index;
} Edge;

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    x = find(parent, x);
    y = find(parent, y);

    if (x != y) {
        if (rank[x] < rank[y])
            parent[x] = y;
        else if (rank[x] > rank[y])
            parent[y] = x;
        else {
            parent[y] = x;
            rank[x]++;
        }
    }
}

int kruskal(int n, int edgesSize, Edge edges[], int exclude, int include) {
    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int mstWeight = 0;
    int edgesUsed = 0;

    if (include != -1) {
        unite(parent, rank, edges[include].u, edges[include].v);
        mstWeight += edges[include].w;
        edgesUsed++;
    }

    for (int i = 0; i < edgesSize; i++) {
        if (i == exclude) continue;

        int u = edges[i].u;
        int v = edges[i].v;
        int w = edges[i].w;

        if (find(parent, u) != find(parent, v)) {
            unite(parent, rank, u, v);
            mstWeight += w;
            edgesUsed++;
        }
    }

    if (edgesUsed != n - 1) return INT_MAX; // Graph is not connected

    return mstWeight;
}

int compareEdges(const void *a, const void *b) {
    return ((Edge*)a)->w - ((Edge*)b)->w;
}

int** findCriticalAndPseudoCriticalEdges(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize, int** returnColumnSizes){
    Edge edgeList[edgesSize];
    for (int i = 0; i < edgesSize; i++) {
        edgeList[i].u = edges[i][0];
        edgeList[i].v = edges[i][1];
        edgeList[i].w = edges[i][2];
        edgeList[i].index = i;
    }

    qsort(edgeList, edgesSize, sizeof(Edge), compareEdges);

    int minMSTWeight = kruskal(n, edgesSize, edgeList, -1, -1);

    int* criticalEdges = (int*)malloc(edgesSize * sizeof(int));
    int criticalEdgesCount = 0;
    int* pseudoCriticalEdges = (int*)malloc(edgesSize * sizeof(int));
    int pseudoCriticalEdgesCount = 0;

    for (int i = 0; i < edgesSize; i++) {
        // Check if critical
        if (kruskal(n, edgesSize, edgeList, i, -1) > minMSTWeight) {
            criticalEdges[criticalEdgesCount++] = edgeList[i].index;
        } else {
            // Check if pseudo-critical
            if (kruskal(n, edgesSize, edgeList, -1, i) == minMSTWeight) {
                pseudoCriticalEdges[pseudoCriticalEdgesCount++] = edgeList[i].index;
            }
        }
    }

    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = criticalEdges;
    result[1] = pseudoCriticalEdges;

    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = criticalEdgesCount;
    (*returnColumnSizes)[1] = pseudoCriticalEdgesCount;

    *returnSize = 2;

    return result;
}