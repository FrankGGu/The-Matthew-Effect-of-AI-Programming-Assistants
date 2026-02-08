#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfWays(int n, int roads[][3], int roadsSize, int* roadsColSize, int maxDist) {
    int adj[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj[i][j] = (i == j) ? 0 : maxDist + 1;
        }
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        int w = roads[i][2];
        adj[u][v] = w;
        adj[v][u] = w;
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                adj[i][j] = fmin(adj[i][j], adj[i][k] + adj[k][j]);
            }
        }
    }

    int count = 0;
    for (int i = 0; i < (1 << n); i++) {
        int cost = 0;
        for (int u = 0; u < n; u++) {
            if ((i >> u) & 1) {
                for (int v = u + 1; v < n; v++) {
                    if ((i >> v) & 1) {
                        cost += adj[u][v];
                    }
                }
            }
        }
        if (cost <= maxDist) {
            count++;
        }
    }

    return count;
}