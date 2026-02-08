#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int to;
    int weight;
} Edge;

int minCost(int n, int** edges, int edgesSize, int* edgesColSize, int start, int target, int maxMoves) {
    Edge* adj[n];
    int adjSize[n];
    for (int i = 0; i < n; i++) {
        adjSize[i] = 0;
        adj[i] = (Edge*)malloc(edgesSize * sizeof(Edge));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        adj[u][adjSize[u]].to = v;
        adj[u][adjSize[u]].weight = w;
        adjSize[u]++;
        adj[v][adjSize[v]].to = u;
        adj[v][adjSize[v]].weight = w;
        adjSize[v]++;
    }

    int dp[maxMoves + 1][n];
    for (int i = 0; i <= maxMoves; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = INT_MAX;
        }
    }
    dp[0][start] = 0;

    for (int moves = 1; moves <= maxMoves; moves++) {
        for (int u = 0; u < n; u++) {
            if (dp[moves - 1][u] != INT_MAX) {
                for (int i = 0; i < adjSize[u]; i++) {
                    int v = adj[u][i].to;
                    int w = adj[u][i].weight;
                    if (dp[moves - 1][u] + w < dp[moves][v]) {
                        dp[moves][v] = dp[moves - 1][u] + w;
                    }
                }
            }
        }
    }

    int min_cost = INT_MAX;
    for (int i = 0; i <= maxMoves; i++) {
        if (dp[i][target] < min_cost) {
            min_cost = dp[i][target];
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }

    return (min_cost == INT_MAX) ? -1 : min_cost;
}