#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007
#define INF 1e18

int countPaths(int n, int** roads, int roadsSize, int* roadsColSize) {
    long long dist[n];
    long long ways[n];
    for (int i = 0; i < n; i++) {
        dist[i] = INF;
        ways[i] = 0;
    }
    dist[0] = 0;
    ways[0] = 1;

    int* visited = (int*)calloc(n, sizeof(int));

    for (int count = 0; count < n; count++) {
        int u = -1;
        for (int i = 0; i < n; i++) {
            if (!visited[i] && (u == -1 || dist[i] < dist[u])) {
                u = i;
            }
        }

        if (u == -1) break;
        visited[u] = 1;

        for (int i = 0; i < roadsSize; i++) {
            int v = -1;
            int time = -1;
            if (roads[i][0] == u) {
                v = roads[i][1];
                time = roads[i][2];
            } else if (roads[i][1] == u) {
                v = roads[i][0];
                time = roads[i][2];
            }

            if (v != -1) {
                if (dist[u] + time < dist[v]) {
                    dist[v] = dist[u] + time;
                    ways[v] = ways[u];
                } else if (dist[u] + time == dist[v]) {
                    ways[v] = (ways[v] + ways[u]) % MOD;
                }
            }
        }
    }

    free(visited);
    return (int)ways[n - 1];
}