#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int to;
    int weight;
} Edge;

int *dijkstra(int n, int start, Edge **adj, int *adjSize) {
    int *dist = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[start] = 0;

    int *visited = (int *)calloc(n, sizeof(int));
    for (int count = 0; count < n - 1; count++) {
        int u = -1;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && (u == -1 || (dist[v] != INT_MAX && dist[v] < dist[u]))) {
                u = v;
            }
        }

        if (u == -1) break;
        visited[u] = 1;

        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i].to;
            int weight = adj[u][i].weight;
            if (dist[u] != INT_MAX && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
            }
        }
    }
    free(visited);
    return dist;
}

long long minimumWeight(int n, int** edges, int edgesSize, int* edgesColSize, int src1, int src2, int dest) {
    Edge **adj = (Edge **)malloc(n * sizeof(Edge *));
    Edge **revAdj = (Edge **)malloc(n * sizeof(Edge *));
    int *adjSize = (int *)calloc(n, sizeof(int));
    int *revAdjSize = (int *)calloc(n, sizeof(int));
    int *adjCapacity = (int *)calloc(n, sizeof(int));
    int *revAdjCapacity = (int *)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        adjCapacity[i] = 10;
        revAdjCapacity[i] = 10;
        adj[i] = (Edge *)malloc(adjCapacity[i] * sizeof(Edge));
        revAdj[i] = (Edge *)malloc(revAdjCapacity[i] * sizeof(Edge));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        if (adjSize[u] == adjCapacity[u]) {
            adjCapacity[u] *= 2;
            adj[u] = (Edge *)realloc(adj[u], adjCapacity[u] * sizeof(Edge));
        }
        adj[u][adjSize[u]].to = v;
        adj[u][adjSize[u]].weight = w;
        adjSize[u]++;

        if (revAdjSize[v] == revAdjCapacity[v]) {
            revAdjCapacity[v] *= 2;
            revAdj[v] = (Edge *)realloc(revAdj[v], revAdjCapacity[v] * sizeof(Edge));
        }
        revAdj[v][revAdjSize[v]].to = u;
        revAdj[v][revAdjSize[v]].weight = w;
        revAdjSize[v]++;
    }

    int *dist1 = dijkstra(n, src1, adj, adjSize);
    int *dist2 = dijkstra(n, src2, adj, adjSize);
    int *distDest = dijkstra(n, dest, revAdj, revAdjSize);

    long long minWeight = LLONG_MAX;
    for (int i = 0; i < n; i++) {
        if (dist1[i] != INT_MAX && dist2[i] != INT_MAX && distDest[i] != INT_MAX) {
            long long currentWeight = (long long)dist1[i] + (long long)dist2[i] + (long long)distDest[i];
            if (currentWeight < minWeight) {
                minWeight = currentWeight;
            }
        }
    }

    free(dist1);
    free(dist2);
    free(distDest);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
        free(revAdj[i]);
    }
    free(adj);
    free(revAdj);
    free(adjSize);
    free(revAdjSize);
    free(adjCapacity);
    free(revAdjCapacity);

    return (minWeight == LLONG_MAX) ? -1 : minWeight;
}