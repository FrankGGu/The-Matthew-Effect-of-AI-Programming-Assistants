#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 1001
#define INF 0x3f3f3f3f

typedef struct {
    int to;
    int weight;
} Edge;

typedef struct {
    Edge edges[MAXN];
    int count;
} AdjList;

int maxPathQuality(int* values, int valuesSize, int** edges, int edgesSize, int* edgesColSize, int maxTime) {
    AdjList adj[valuesSize];
    for (int i = 0; i < valuesSize; i++) {
        adj[i].count = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        adj[u].edges[adj[u].count].to = v;
        adj[u].edges[adj[u].count].weight = w;
        adj[u].count++;

        adj[v].edges[adj[v].count].to = u;
        adj[v].edges[adj[v].count].weight = w;
        adj[v].count++;
    }

    int maxQuality = 0;
    int visited[valuesSize];
    for (int i = 0; i < valuesSize; i++) {
        visited[i] = 0;
    }

    visited[0] = 1;

    void dfs(int node, int currentTime, int currentQuality) {
        if (node == 0) {
            if (currentQuality > maxQuality) {
                maxQuality = currentQuality;
            }
        }

        for (int i = 0; i < adj[node].count; i++) {
            int neighbor = adj[node].edges[i].to;
            int weight = adj[node].edges[i].weight;

            if (currentTime + weight <= maxTime) {
                if (visited[neighbor] == 0) {
                    visited[neighbor] = 1;
                    dfs(neighbor, currentTime + weight, currentQuality + values[neighbor]);
                    visited[neighbor] = 0;
                } else {
                    dfs(neighbor, currentTime + weight, currentQuality);
                }
            }
        }
    }

    dfs(0, 0, values[0]);

    return maxQuality;
}