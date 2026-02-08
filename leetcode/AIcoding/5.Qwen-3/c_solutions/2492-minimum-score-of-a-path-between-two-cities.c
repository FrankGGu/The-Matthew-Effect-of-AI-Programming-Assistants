#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int to;
    int weight;
} Edge;

typedef struct {
    Edge* edges;
    int edgeCount;
} AdjList;

int minScore(int n, int** roads, int roadsSize, int* roadsColSize) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].edges = NULL;
        adj[i].edgeCount = 0;
    }

    for (int i = 0; i < roadsSize; i++) {
        int from = roads[i][0];
        int to = roads[i][1];
        int weight = roads[i][2];

        adj[from].edges = (Edge*)realloc(adj[from].edges, (adj[from].edgeCount + 1) * sizeof(Edge));
        adj[from].edges[adj[from].edgeCount].to = to;
        adj[from].edges[adj[from].edgeCount].weight = weight;
        adj[from].edgeCount++;

        adj[to].edges = (Edge*)realloc(adj[to].edges, (adj[to].edgeCount + 1) * sizeof(Edge));
        adj[to].edges[adj[to].edgeCount].to = from;
        adj[to].edges[adj[to].edgeCount].weight = weight;
        adj[to].edgeCount++;
    }

    int visited[n];
    for (int i = 0; i < n; i++) visited[i] = 0;

    int minScore = INT_MAX;
    int queue[n];
    int front = 0, rear = 0;

    queue[rear++] = 0;
    visited[0] = 1;

    while (front < rear) {
        int current = queue[front++];
        for (int i = 0; i < adj[current].edgeCount; i++) {
            int neighbor = adj[current].edges[i].to;
            int weight = adj[current].edges[i].weight;
            if (!visited[neighbor]) {
                visited[neighbor] = 1;
                queue[rear++] = neighbor;
            }
            if (weight < minScore) {
                minScore = weight;
            }
        }
    }

    for (int i = 0; i < n; i++) free(adj[i].edges);
    free(adj);

    return minScore;
}