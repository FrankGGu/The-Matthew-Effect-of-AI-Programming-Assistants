#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef struct {
    int to;
    int weight;
} Edge;

int countPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    Edge* adj[n + 1];
    int adjSize[n + 1];
    for (int i = 1; i <= n; i++) {
        adj[i] = (Edge*)malloc(edgesSize * sizeof(Edge));
        adjSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        adj[u][adjSize[u]].to = v;
        adj[u][adjSize[u]].weight = w;
        adjSize[u]++;
    }

    long long dist[n + 1];
    int ways[n + 1];
    for (int i = 1; i <= n; i++) {
        dist[i] = -1;
        ways[i] = 0;
    }

    dist[1] = 0;
    ways[1] = 1;

    bool updated = true;
    for (int k = 1; k <= n && updated; k++) {
        updated = false;
        for (int u = 1; u <= n; u++) {
            if (dist[u] == -1) continue;
            for (int i = 0; i < adjSize[u]; i++) {
                int v = adj[u][i].to;
                int w = adj[u][i].weight;

                if (dist[v] == -1 || dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    ways[v] = ways[u];
                    updated = true;
                } else if (dist[v] == dist[u] + w) {
                    ways[v] = (ways[v] + ways[u]) % MOD;
                }
            }
        }
    }
    if(dist[n] == -1) return 0;
    return ways[n];
}

int numberOfWays(int n, int** edges, int edgesSize, int* edgesColSize) {
    int forwardWays = countPaths(n, edges, edgesSize, edgesColSize);

    int** reversedEdges = (int**)malloc(edgesSize * sizeof(int*));
    for (int i = 0; i < edgesSize; i++) {
        reversedEdges[i] = (int*)malloc(3 * sizeof(int));
        reversedEdges[i][0] = edges[i][1];
        reversedEdges[i][1] = edges[i][0];
        reversedEdges[i][2] = edges[i][2];
    }

    int backwardWays = countPaths(n, reversedEdges, edgesSize, edgesColSize);

    for(int i = 0; i < edgesSize; i++){
        free(reversedEdges[i]);
    }
    free(reversedEdges);

    return (forwardWays - backwardWays + MOD) % MOD;
}