#include <limits.h>
#include <stdlib.h>
#include <stdio.h>

int findTheCity(int n, int** edges, int edgesSize, int* edgesColSize, int threshold) {
    long long** dist = (long long**)malloc(n * sizeof(long long*));
    for (int i = 0; i < n; i++) {
        dist[i] = (long long*)malloc(n * sizeof(long long));
        for (int j = 0; j < n; j++) {
            if (i == j) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = LLONG_MAX;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        dist[u][v] = w;
        dist[v][u] = w;
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (dist[i][k] != LLONG_MAX && dist[k][j] != LLONG_MAX) {
                    if (dist[i][j] > dist[i][k] + dist[k][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }
    }

    int minNeighbors = n + 1;
    int resultCity = -1;

    for (int i = 0; i < n; i++) {
        int currentNeighbors = 0;
        for (int j = 0; j < n; j++) {
            if (i == j) continue;
            if (dist[i][j] <= threshold) {
                currentNeighbors++;
            }
        }

        if (currentNeighbors <= minNeighbors) {
            minNeighbors = currentNeighbors;
            resultCity = i;
        }
    }

    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);

    return resultCity;
}