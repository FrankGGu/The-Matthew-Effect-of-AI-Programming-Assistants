#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

int minTime(int n, int** edges, int edgesSize, int* edgesColSize, int* time, int* changed) {
    int adj[MAXN];
    int adj_count[MAXN];
    for (int i = 0; i < n; i++) {
        adj_count[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u * n + adj_count[u]++] = v;
        adj[v * n + adj_count[v]++] = u;
    }

    long long total_time = 0;
    bool visited[MAXN];
    for (int i = 0; i < n; i++) {
        visited[i] = false;
    }

    int queue[MAXN];
    int queue_start = 0;
    int queue_end = 0;
    queue[queue_end++] = 0;
    visited[0] = true;

    while (queue_start < queue_end) {
        int u = queue[queue_start++];
        total_time += time[u];

        for (int i = 0; i < adj_count[u]; i++) {
            int v = adj[u * n + i];
            if (!visited[v] && (changed[u] == 0 || time[u] < changed[u])) {
                queue[queue_end++] = v;
                visited[v] = true;
            }
        }
    }

    return (int)total_time;
}