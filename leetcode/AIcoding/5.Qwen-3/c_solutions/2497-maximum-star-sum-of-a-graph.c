#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)b - *(int *)a);
}

int maximumStarSum(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize) {
    int* graph = (int*)calloc(valsSize, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u] += vals[v];
        graph[v] += vals[u];
    }

    int maxSum = 0;
    for (int i = 0; i < valsSize; i++) {
        int* neighbors = (int*)malloc(sizeof(int) * edgesSize);
        int count = 0;
        for (int j = 0; j < edgesSize; j++) {
            if (edges[j][0] == i) {
                neighbors[count++] = vals[edges[j][1]];
            } else if (edges[j][1] == i) {
                neighbors[count++] = vals[edges[j][0]];
            }
        }
        qsort(neighbors, count, sizeof(int), compare);
        int sum = vals[i];
        for (int k = 0; k < count && k < 2; k++) {
            if (neighbors[k] > 0) {
                sum += neighbors[k];
            }
        }
        if (sum > maxSum) {
            maxSum = sum;
        }
        free(neighbors);
    }
    free(graph);
    return maxSum;
}