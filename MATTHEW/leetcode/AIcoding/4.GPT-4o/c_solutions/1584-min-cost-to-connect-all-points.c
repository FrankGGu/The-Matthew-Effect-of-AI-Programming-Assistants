#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int u;
    int v;
    int cost;
} Edge;

int compare(const void *a, const void *b) {
    return ((Edge *)a)->cost - ((Edge *)b)->cost;
}

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

int minCostConnectPoints(int** points, int pointsSize, int* pointsColSize) {
    Edge *edges = (Edge *)malloc(sizeof(Edge) * (pointsSize * (pointsSize - 1) / 2));
    int edgeCount = 0;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            edges[edgeCount].u = i;
            edges[edgeCount].v = j;
            edges[edgeCount].cost = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
            edgeCount++;
        }
    }

    qsort(edges, edgeCount, sizeof(Edge), compare);

    int *parent = (int *)malloc(sizeof(int) * pointsSize);
    int *rank = (int *)calloc(pointsSize, sizeof(int));
    for (int i = 0; i < pointsSize; i++) {
        parent[i] = i;
    }

    int totalCost = 0;
    int edgesUsed = 0;

    for (int i = 0; i < edgeCount && edgesUsed < pointsSize - 1; i++) {
        if (find(parent, edges[i].u) != find(parent, edges[i].v)) {
            unionSets(parent, rank, edges[i].u, edges[i].v);
            totalCost += edges[i].cost;
            edgesUsed++;
        }
    }

    free(edges);
    free(parent);
    free(rank);

    return totalCost;
}