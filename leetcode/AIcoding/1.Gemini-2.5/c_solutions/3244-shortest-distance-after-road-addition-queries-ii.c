#include <stdlib.h>
#include <limits.h> // For LLONG_MAX

#define MIN(a, b) ((a) < (b) ? (a) : (b))

long long* shortestDistanceQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    long long** dist = (long long**)malloc(n * sizeof(long long*));
    long long INF = LLONG_MAX / 2; // Use LLONG_MAX / 2 to prevent overflow when adding

    for (int i = 0; i < n; ++i) {
        dist[i] = (long long*)malloc(n * sizeof(long long));
        for (int j = 0; j < n; ++j) {
            if (i == j) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = INF;
            }
        }
    }

    long long* results = (long long*)malloc(queriesSize * sizeof(long long));
    *returnSize = queriesSize;

    for (int q = 0; q < queriesSize; ++q) {
        int u = queries[q][0] - 1; // Adjust to 0-indexed
        int v = queries[q][1] - 1; // Adjust to 0-indexed
        int w = queries[q][2];
        int s = queries[q][3] - 1; // Adjust to 0-indexed
        int t = queries[q][4] - 1; // Adjust to 0-indexed

        // Update direct path for the new road (undirected)
        dist[u][v] = MIN(dist[u][v], (long long)w);
        dist[v][u] = MIN(dist[v][u], (long long)w);

        // Propagate changes to all-pairs shortest paths
        // For every pair (i, j), check if a path through u-v or v-u is shorter.
        // This is an O(N^2) update for each added edge.
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                // Path i -> ... -> u -> v -> ... -> j
                if (dist[i][u] != INF && dist[v][j] != INF) {
                    dist[i][j] = MIN(dist[i][j], dist[i][u] + dist[u][v] + dist[v][j]);
                }
                // Path i -> ... -> v -> u -> ... -> j
                if (dist[i][v] != INF && dist[u][j] != INF) {
                    dist[i][j] = MIN(dist[i][j], dist[i][v] + dist[v][u] + dist[u][j]);
                }
            }
        }

        // Record the result for the current query
        if (dist[s][t] == INF) {
            results[q] = -1;
        } else {
            results[q] = dist[s][t];
        }
    }

    // Free allocated memory
    for (int i = 0; i < n; ++i) {
        free(dist[i]);
    }
    free(dist);

    return results;
}