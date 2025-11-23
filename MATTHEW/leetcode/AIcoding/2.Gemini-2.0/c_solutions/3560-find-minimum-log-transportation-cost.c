#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 105
#define INF INT_MAX

int n, m, start, end;
int adj[MAXN][MAXN];
int dist[MAXN];
int visited[MAXN];

int minDistance() {
    int min = INF, min_index;
    for (int v = 1; v <= n; v++) {
        if (visited[v] == 0 && dist[v] <= min) {
            min = dist[v];
            min_index = v;
        }
    }
    return min_index;
}

int solve() {
    for (int i = 1; i <= n; i++) {
        dist[i] = INF;
        visited[i] = 0;
    }
    dist[start] = 0;

    for (int count = 1; count <= n - 1; count++) {
        int u = minDistance();
        visited[u] = 1;
        for (int v = 1; v <= n; v++) {
            if (!visited[v] && adj[u][v] && dist[u] != INF && dist[u] + adj[u][v] < dist[v]) {
                dist[v] = dist[u] + adj[u][v];
            }
        }
    }
    return (dist[end] == INF) ? -1 : dist[end];
}