#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* neighbors;
    int size;
} AdjList;

typedef struct {
    int node;
    int time;
} NodeTime;

int compare(const void* a, const void. *b) {
    return ((NodeTime*)a)->time - ((NodeTime*)b)->time;
}

int minTimeToVisitAllNodes(int** edges, int edgesSize, int* edgesColSize, int bobStart, int aliceStart, int* result) {
    int n = edgesSize + 1;
    AdjList adj[n];
    for (int i = 0; i < n; i++) {
        adj[i].neighbors = NULL;
        adj[i].size = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int* newNeighbors = realloc(adj[u].neighbors, sizeof(int) * (adj[u].size + 1));
        newNeighbors[adj[u].size++] = v;
        adj[u].neighbors = newNeighbors;

        newNeighbors = realloc(adj[v].neighbors, sizeof(int) * (adj[v].size + 1));
        newNeighbors[adj[v].size++] = u;
        adj[v].neighbors = newNeighbors;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    NodeTime* queue = (NodeTime*)malloc(n * sizeof(NodeTime));
    int front = 0, rear = 0;

    queue[rear++] = (NodeTime){aliceStart, 0};
    visited[aliceStart] = 1;

    int* aliceTime = (int*)calloc(n, sizeof(int));
    while (front < rear) {
        NodeTime current = queue[front++];
        aliceTime[current.node] = current.time;

        for (int i = 0; i < adj[current.node].size; i++) {
            int neighbor = adj[current.node].neighbors[i];
            if (!visited[neighbor]) {
                visited[neighbor] = 1;
                queue[rear++] = (NodeTime){neighbor, current.time + 1};
            }
        }
    }

    free(visited);
    free(queue);

    visited = (int*)calloc(n, sizeof(int));
    queue = (NodeTime*)malloc(n * sizeof(NodeTime));
    front = rear = 0;

    queue[rear++] = (NodeTime){bobStart, 0};
    visited[bobStart] = 1;

    int* bobTime = (int*)calloc(n, sizeof(int));
    while (front < rear) {
        NodeTime current = queue[front++];
        bobTime[current.node] = current.time;

        for (int i = 0; i < adj[current.node].size; i++) {
            int neighbor = adj[current.node].neighbors[i];
            if (!visited[neighbor]) {
                visited[neighbor] = 1;
                queue[rear++] = (NodeTime){neighbor, current.time + 1};
            }
        }
    }

    free(visited);
    free(queue);

    int maxTime = 0;
    for (int i = 0; i < n; i++) {
        if (aliceTime[i] < bobTime[i]) {
            maxTime = (maxTime > aliceTime[i]) ? maxTime : aliceTime[i];
        } else {
            maxTime = (maxTime > bobTime[i]) ? maxTime : bobTime[i];
        }
    }

    *result = maxTime;

    for (int i = 0; i < n; i++) {
        free(adj[i].neighbors);
    }

    free(aliceTime);
    free(bobTime);

    return *result;
}