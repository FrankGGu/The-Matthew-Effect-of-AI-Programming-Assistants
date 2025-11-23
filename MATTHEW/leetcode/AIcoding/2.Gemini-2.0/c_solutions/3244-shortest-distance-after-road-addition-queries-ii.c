#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INF 1e18

typedef long long ll;

typedef struct {
    int u, v, w;
} Edge;

ll** floydWarshall(int n, int m, int[][] edges) {
    ll** dist = (ll**)malloc(n * sizeof(ll*));
    for (int i = 0; i < n; i++) {
        dist[i] = (ll*)malloc(n * sizeof(ll));
        for (int j = 0; j < n; j++) {
            if (i == j) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = INF;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        dist[edges[i][0]][edges[i][1]] = edges[i][2];
        dist[edges[i][1]][edges[i][0]] = edges[i][2];
    }

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (dist[i][k] != INF && dist[k][j] != INF && dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    return dist;
}

long long* shortestDistance(int n, int[][] edges, int[][] queries) {
    int m = 0;
    for (int i = 0; edges[i][0] != -1; i++) {
        m++;
    }

    ll** dist = floydWarshall(n, m, edges);

    int q = 0;
    for (int i = 0; queries[i][0] != -1; i++) {
        q++;
    }

    long long* result = (long long*)malloc(q * sizeof(long long));

    for (int i = 0; i < q; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        if (dist[u][v] == INF) {
            result[i] = -1;
        } else {
            result[i] = dist[u][v];
        }
    }

    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);

    return result;
}