#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numBusesToDestination(int** routes, int routesSize, int* routesColSize, int source, int target) {
    if (source == target) {
        return 0;
    }

    int n = 0;
    for (int i = 0; i < routesSize; i++) {
        for (int j = 0; j < routesColSize[i]; j++) {
            if (routes[i][j] > n) {
                n = routes[i][j];
            }
        }
    }

    int *adj[routesSize];
    for (int i = 0; i < routesSize; i++) {
        adj[i] = (int*)malloc(sizeof(int) * routesSize);
        for (int j = 0; j < routesSize; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < routesSize; i++) {
        for (int j = i + 1; j < routesSize; j++) {
            for (int k = 0; k < routesColSize[i]; k++) {
                for (int l = 0; l < routesColSize[j]; l++) {
                    if (routes[i][k] == routes[j][l]) {
                        adj[i][j] = 1;
                        adj[j][i] = 1;
                        break;
                    }
                }
                if (adj[i][j] == 1) break;
            }
        }
    }

    int queue[routesSize + 1];
    int head = 0, tail = 0;
    int dist[routesSize];
    for (int i = 0; i < routesSize; i++) {
        dist[i] = -1;
    }

    for (int i = 0; i < routesSize; i++) {
        for (int j = 0; j < routesColSize[i]; j++) {
            if (routes[i][j] == source) {
                queue[tail++] = i;
                dist[i] = 1;
                break;
            }
        }
    }

    while (head < tail) {
        int u = queue[head++];

        for (int v = 0; v < routesSize; v++) {
            if (adj[u][v] == 1 && dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[tail++] = v;
            }
        }
    }

    int ans = 1000000;
    for (int i = 0; i < routesSize; i++) {
        for (int j = 0; j < routesColSize[i]; j++) {
            if (routes[i][j] == target && dist[i] != -1) {
                ans = (ans < dist[i]) ? ans : dist[i];
                break;
            }
        }
    }

    for (int i = 0; i < routesSize; i++) {
        free(adj[i]);
    }

    return (ans == 1000000) ? -1 : ans;
}