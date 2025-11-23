#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countSubgraphsForMaxDistance(int n, int* edges, int edgesSize, int** queries, int queriesSize, int* returnSize) {
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        memset(adj[i], 0, n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i];
        int v = edges[i + 1];
        adj[u][v] = 1;
        adj[v][u] = 1;
    }

    int* result = (int*)malloc(n * sizeof(int));
    memset(result, 0, n * sizeof(int));

    for (int mask = 1; mask < (1 << n); mask++) {
        int cities[n];
        int cnt = 0;
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                cities[cnt++] = i;
            }
        }

        int dist[n];
        int visited[n];
        int queue[n];
        int front = 0, rear = 0;

        for (int i = 0; i < n; i++) {
            dist[i] = -1;
        }

        for (int i = 0; i < cnt; i++) {
            dist[cities[i]] = 0;
            queue[rear++] = cities[i];
        }

        while (front < rear) {
            int u = queue[front++];
            for (int v = 0; v < n; v++) {
                if (adj[u][v] && dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue[rear++] = v;
                }
            }
        }

        int maxDist = 0;
        for (int i = 0; i < cnt; i++) {
            if (dist[cities[i]] > maxDist) {
                maxDist = dist[cities[i]];
            }
        }

        int valid = 1;
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) && dist[i] == -1) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            result[maxDist]++;
        }
    }

    *returnSize = n;
    return result;
}