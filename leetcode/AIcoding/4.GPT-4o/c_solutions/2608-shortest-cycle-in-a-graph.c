#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAXN 1000

int graph[MAXN][MAXN];
int visited[MAXN];
int dist[MAXN];

int min(int a, int b) {
    return a < b ? a : b;
}

void dfs(int node, int parent, int n, int *cycle_length, int depth) {
    visited[node] = 1;
    dist[node] = depth;

    for (int i = 0; i < n; i++) {
        if (graph[node][i]) {
            if (!visited[i]) {
                dfs(i, node, n, cycle_length, depth + 1);
            } else if (i != parent) {
                *cycle_length = min(*cycle_length, dist[node] + dist[i] + 1);
            }
        }
    }

    visited[node] = 0;
}

int findShortestCycle(int n, int** edges, int edgesSize, int* edgesColSize) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][edges[i][1]] = 1;
        graph[edges[i][1]][edges[i][0]] = 1;
    }

    int cycle_length = INT_MAX;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i, -1, n, &cycle_length, 0);
        }
    }

    return cycle_length == INT_MAX ? -1 : cycle_length;
}