#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int modifiedGraphEdges(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination, int target) {
    int adj[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj[i][j] = -1;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        adj[u][v] = w;
        adj[v][u] = w;
    }

    int dist[n];
    for (int i = 0; i < n; i++) {
        dist[i] = 1e9;
    }
    dist[source] = 0;

    int visited[n];
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    for (int count = 0; count < n - 1; count++) {
        int u = -1;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && (u == -1 || dist[v] < dist[u])) {
                u = v;
            }
        }

        if (u == -1) break;

        visited[u] = 1;

        for (int v = 0; v < n; v++) {
            if (adj[u][v] != -1) {
                int weight = adj[u][v];
                if (weight == -1) weight = 1e9;
                if (dist[u] + (weight == 1e9 ? 1 : weight) < dist[v]) {
                    dist[v] = dist[u] + (weight == 1e9 ? 1 : weight);
                }
            }
        }
    }

    if (dist[destination] < target) return 0;

    int count = 0;
    for(int i = 0; i < edgesSize; i++){
        if(edges[i][2] == -1){
            edges[i][2] = 1;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        adj[u][v] = w;
        adj[v][u] = w;
    }

    for(int i = 0; i < edgesSize; i++){
        if(adj[edges[i][0]][edges[i][1]] == -1){
            adj[edges[i][0]][edges[i][1]] = edges[i][2];
            adj[edges[i][1]][edges[i][0]] = edges[i][2];
        }
    }

    for (int i = 0; i < n; i++) {
        dist[i] = 1e9;
    }
    dist[source] = 0;

    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    for (int count_d = 0; count_d < n - 1; count_d++) {
        int u = -1;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && (u == -1 || dist[v] < dist[u])) {
                u = v;
            }
        }

        if (u == -1) break;

        visited[u] = 1;

        for (int v = 0; v < n; v++) {
            if (adj[u][v] != -1) {
                int weight = adj[u][v];
                if (weight == -1) weight = 1e9;
                if (dist[u] + (weight == 1e9 ? 1 : weight) < dist[v]) {
                    dist[v] = dist[u] + (weight == 1e9 ? 1 : weight);
                }
            }
        }
    }

    if(dist[destination] != target) return -1;

    return 1;
}