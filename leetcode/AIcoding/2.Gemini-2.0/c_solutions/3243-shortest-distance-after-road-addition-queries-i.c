#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* shortestDistance(int n, int** edges, int edgesSize, int* edgesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    long long dist[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i == j) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = LLONG_MAX;
            }
        }
    }
    for (int i = 0; i < edgesSize; i++) {
        dist[edges[i][0]][edges[i][1]] = edges[i][2];
        dist[edges[i][1]][edges[i][0]] = edges[i][2];
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (dist[i][k] != LLONG_MAX && dist[k][j] != LLONG_MAX && dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; i++) {
        if (dist[queries[i][0]][queries[i][1]] == LLONG_MAX) {
            result[i] = -1;
        } else {
            result[i] = (int)dist[queries[i][0]][queries[i][1]];
        }
    }

    return result;
}