#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int to;
    int cost;
} Edge;

typedef struct {
    Edge* edges;
    int size;
} AdjList;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int findCheapestPrice(int n, int** flights, int flightsSize, int* flightsColSize, int src, int dst, int k) {
    AdjList adj[n];
    for (int i = 0; i < n; i++) {
        adj[i].edges = NULL;
        adj[i].size = 0;
    }

    for (int i = 0; i < flightsSize; i++) {
        int from = flights[i][0];
        int to = flights[i][1];
        int cost = flights[i][2];

        adj[from].size++;
        adj[from].edges = realloc(adj[from].edges, adj[from].size * sizeof(Edge));
        adj[from].edges[adj[from].size - 1] = (Edge){to, cost};
    }

    int dist[n];
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[src] = 0;

    for (int i = 0; i <= k; i++) {
        int tempDist[n];
        for (int j = 0; j < n; j++) {
            tempDist[j] = dist[j];
        }

        for (int u = 0; u < n; u++) {
            if (dist[u] != INT_MAX) {
                for (int m = 0; m < adj[u].size; m++) {
                    Edge e = adj[u].edges[m];
                    if (dist[u] + e.cost < tempDist[e.to]) {
                        tempDist[e.to] = dist[u] + e.cost;
                    }
                }
            }
        }

        for (int j = 0; j < n; j++) {
            dist[j] = tempDist[j];
        }
    }

    return dist[dst] == INT_MAX ? -1 : dist[dst];
}