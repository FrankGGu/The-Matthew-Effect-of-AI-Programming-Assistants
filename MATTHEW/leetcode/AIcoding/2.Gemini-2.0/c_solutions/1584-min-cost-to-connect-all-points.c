#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int u;
    int v;
    int weight;
} Edge;

int compareEdges(const void *a, const void *b) {
    return ((Edge*)a)->weight - ((Edge*)b)->weight;
}

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    int xroot = find(parent, x);
    int yroot = find(parent, y);

    if (xroot != yroot) {
        if (rank[xroot] < rank[yroot])
            parent[xroot] = yroot;
        else if (rank[xroot] > rank[yroot])
            parent[yroot] = xroot;
        else {
            parent[yroot] = xroot;
            rank[xroot]++;
        }
    }
}

int minCostConnectPoints(int** points, int pointsSize, int* pointsColSize){
    int n = pointsSize;
    int numEdges = n * (n - 1) / 2;
    Edge edges[numEdges];
    int edgeIndex = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int weight = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
            edges[edgeIndex].u = i;
            edges[edgeIndex].v = j;
            edges[edgeIndex].weight = weight;
            edgeIndex++;
        }
    }

    qsort(edges, numEdges, sizeof(Edge), compareEdges);

    int parent[n];
    int rank[n];
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int minCost = 0;
    int numEdgesIncluded = 0;
    int i = 0;
    while (numEdgesIncluded < n - 1 && i < numEdges) {
        Edge edge = edges[i];
        int u = edge.u;
        int v = edge.v;
        int weight = edge.weight;

        if (find(parent, u) != find(parent, v)) {
            unite(parent, rank, u, v);
            minCost += weight;
            numEdgesIncluded++;
        }
        i++;
    }

    return minCost;
}