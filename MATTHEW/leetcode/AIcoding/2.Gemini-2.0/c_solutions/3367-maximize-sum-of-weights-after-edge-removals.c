#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int u;
    int v;
    int w;
} Edge;

int compareEdges(const void *a, const void *b) {
    return ((Edge*)b)->w - ((Edge*)a)->w;
}

long long maxWeightSum(int n, int** edges, int edgesSize, int* edgesColSize, int k) {
    Edge edge_arr[edgesSize];
    for (int i = 0; i < edgesSize; i++) {
        edge_arr[i].u = edges[i][0];
        edge_arr[i].v = edges[i][1];
        edge_arr[i].w = edges[i][2];
    }

    qsort(edge_arr, edgesSize, sizeof(Edge), compareEdges);

    long long sum = 0;
    for (int i = 0; i < edgesSize - k; i++) {
        sum += edge_arr[i].w;
    }

    return sum;
}