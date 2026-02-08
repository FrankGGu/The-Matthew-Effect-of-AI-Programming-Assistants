#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int to;
    int weight;
} Edge;

int compare(const void* a, const void* b) {
    return ((Edge*)b)->weight - ((Edge*)a)->weight;
}

int maxSum(int n, int** edges, int k) {
    Edge* edgeList = (Edge*)malloc(n * sizeof(Edge));
    for (int i = 0; i < n; ++i) {
        edgeList[i].to = edges[i][0];
        edgeList[i].weight = edges[i][1];
    }

    qsort(edgeList, n, sizeof(Edge), compare);

    int sum = 0;
    int count = 0;
    int visited[100000] = {0};

    for (int i = 0; i < n && count < k; ++i) {
        int u = edgeList[i].to;
        int v = edges[i][1];
        if (!visited[u] && !visited[v]) {
            sum += edgeList[i].weight;
            visited[u] = 1;
            visited[v] = 1;
            count++;
        }
    }

    free(edgeList);
    return sum;
}