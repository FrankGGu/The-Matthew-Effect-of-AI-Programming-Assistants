#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>

#define MAX_N 200
#define MOD 1000000007

int countPaths(int n, int** roads, int roadsSize, int* roadsColSize) {
    long long adj_matrix[MAX_N][MAX_N];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj_matrix[i][j] = LLONG_MAX;
        }
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        int time = roads[i][2];
        adj_matrix[u][v] = time;
        adj_matrix[v][u] = time;
    }

    long long dist[MAX_N];
    int ways[MAX_N];
    bool visited[MAX_N];

    for (int i = 0; i < n; i++) {
        dist[i] = LLONG_MAX;
        ways[i] = 0;
        visited[i] = false;
    }

    dist[0] = 0;
    ways[0] = 1;

    for (int count = 0; count < n; count++) {
        long long min_dist = LLONG_MAX;
        int u = -1;

        for (int v = 0; v < n; v++) {
            if (!visited[v] && dist[v] < min_dist) {
                min_dist = dist[v];
                u = v;
            }
        }

        if (u == -1) {
            break;
        }

        visited[u] = true;

        for (int v = 0; v < n; v++) {
            if (adj_matrix[u][v] != LLONG_MAX && dist[u] != LLONG_MAX) {
                long long new_dist = dist[u] + adj_matrix[u][v];

                if (new_dist < dist[v]) {
                    dist[v] = new_dist;
                    ways[v] = ways[u];
                } else if (new_dist == dist[v]) {
                    ways[v] = (ways[v] + ways[u]) % MOD;
                }
            }
        }
    }

    return ways[n - 1];
}