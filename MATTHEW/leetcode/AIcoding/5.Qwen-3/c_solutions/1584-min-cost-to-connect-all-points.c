#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int u;
    int v;
    int weight;
} Edge;

int compareEdges(const void* a, const void* b) {
    return ((Edge*)a)->weight - ((Edge*)b)->weight;
}

int find(int* parent, int x) {
    if (parent[x] != x)
        parent[x] = find(parent, parent[x]);
    return parent[x];
}

void unionSets(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY])
            parent[rootY] = rootX;
        else {
            parent[rootX] = rootY;
            if (rank[rootX] == rank[rootY])
                rank[rootY]++;
        }
    }
}

int minCostConnectPoints(int** points, int pointsSize, int* pointsColSize) {
    int n = pointsSize;
    Edge* edges = (Edge*)malloc(n * (n - 1) / 2 * sizeof(Edge));
    int edgeCount = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int dx = abs(points[i][0] - points[j][0]);
            int dy = abs(points[i][1] - points[j][1]);
            int weight = dx + dy;
            edges[edgeCount++] = (Edge){i, j, weight};
        }
    }

    qsort(edges, edgeCount, sizeof(Edge), compareEdges);

    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int totalCost = 0;
    int edgesUsed = 0;

    for (int i = 0; i < edgeCount && edgesUsed < n - 1; i++) {
        Edge e = edges[i];
        int rootU = find(parent, e.u);
        int rootV = find(parent, e.v);
        if (rootU != rootV) {
            unionSets(parent, rank, rootU, rootV);
            totalCost += e.weight;
            edgesUsed++;
        }
    }

    free(edges);
    free(parent);
    free(rank);

    return totalCost;
}