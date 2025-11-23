#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int networkDelayTime(int** times, int timesSize, int* timesColSize, int n, int k) {
    int dist[n + 1];
    for (int i = 1; i <= n; i++) {
        dist[i] = INT_MAX;
    }
    dist[k] = 0;

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < timesSize; j++) {
            int u = times[j][0];
            int v = times[j][1];
            int w = times[j][2];

            if (dist[u] != INT_MAX && dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
            }
        }
    }

    int max_delay = 0;
    for (int i = 1; i <= n; i++) {
        if (dist[i] == INT_MAX) {
            return -1;
        }
        if (dist[i] > max_delay) {
            max_delay = dist[i];
        }
    }

    return max_delay;
}