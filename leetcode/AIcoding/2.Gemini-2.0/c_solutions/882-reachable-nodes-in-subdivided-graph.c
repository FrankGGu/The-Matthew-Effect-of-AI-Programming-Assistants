#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 3005

typedef struct Edge {
    int to, weight;
} Edge;

int reachableNodes(int n, int** edges, int edgesSize, int* edgesColSize, int maxMoves) {
    Edge adj[MAXN][MAXN];
    int adjSize[MAXN] = {0};
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1], w = edges[i][2];
        adj[u][adjSize[u]].to = v;
        adj[u][adjSize[u]].weight = w + 1;
        adjSize[u]++;
        adj[v][adjSize[v]].to = u;
        adj[v][adjSize[v]].weight = w + 1;
        adjSize[v]++;
    }

    int dist[MAXN];
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }
    dist[0] = maxMoves;

    int visited[MAXN] = {0};
    int ans = 0;
    for (int i = 0; i < n; i++) {
        int u = -1;
        for (int j = 0; j < n; j++) {
            if (!visited[j] && dist[j] != -1 && (u == -1 || dist[j] > dist[u])) {
                u = j;
            }
        }
        if (u == -1) break;
        visited[u] = 1;
        ans++;

        for (int j = 0; j < adjSize[u]; j++) {
            int v = adj[u][j].to, w = adj[u][j].weight;
            if (dist[u] - w >= 0) {
                if (dist[v] < dist[u] - w) {
                    dist[v] = dist[u] - w;
                }
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1], w = edges[i][2];
        int a = (dist[u] == -1) ? 0 : dist[u];
        int b = (dist[v] == -1) ? 0 : dist[v];
        int add = 0;
        if (a > 0) add += a;
        if (b > 0) add += b;
        ans += (add > w) ? w : add;
    }

    return ans;
}