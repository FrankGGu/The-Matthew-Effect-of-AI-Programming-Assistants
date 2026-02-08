#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximalNetworkRank(int n, int** roads, int roadsSize, int* roadsColSize) {
    int degree[n];
    for (int i = 0; i < n; i++) {
        degree[i] = 0;
    }

    int adj[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        degree[u]++;
        degree[v]++;
        adj[u][v] = 1;
        adj[v][u] = 1;
    }

    int maxRank = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int rank = degree[i] + degree[j];
            if (adj[i][j] == 1) {
                rank--;
            }
            if (rank > maxRank) {
                maxRank = rank;
            }
        }
    }

    return maxRank;
}