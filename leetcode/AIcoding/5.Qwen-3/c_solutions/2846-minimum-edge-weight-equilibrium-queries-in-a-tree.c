#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

typedef struct {
    Edge* head;
} AdjList;

int* minEdgeEquilibriumQueries(int n, int** edges, int edgesSize, int* queries, int queriesSize, int* returnSize) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].head = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        Edge* newEdge = (Edge*)malloc(sizeof(Edge));
        newEdge->to = v;
        newEdge->weight = w;
        newEdge->next = adj[u].head;
        adj[u].head = newEdge;

        newEdge = (Edge*)malloc(sizeof(Edge));
        newEdge->to = u;
        newEdge->weight = w;
        newEdge->next = adj[v].head;
        adj[v].head = newEdge;
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int q = 0; q < queriesSize; q++) {
        int u = queries[q];
        int v = queries[q + 1];
        q++;

        int* parent = (int*)malloc(n * sizeof(int));
        int* depth = (int*)malloc(n * sizeof(int));
        int* maxWeight = (int*)malloc(n * sizeof(int));
        int* visited = (int*)malloc(n * sizeof(int));

        for (int i = 0; i < n; i++) {
            parent[i] = -1;
            depth[i] = 0;
            maxWeight[i] = 0;
            visited[i] = 0;
        }

        int* queue = (int*)malloc(n * sizeof(int));
        int front = 0, rear = 0;
        queue[rear++] = u;
        visited[u] = 1;

        while (front < rear) {
            int curr = queue[front++];
            Edge* e = adj[curr].head;
            while (e) {
                if (!visited[e->to]) {
                    visited[e->to] = 1;
                    parent[e->to] = curr;
                    depth[e->to] = depth[curr] + 1;
                    maxWeight[e->to] = e->weight;
                    queue[rear++] = e->to;
                }
                e = e->next;
            }
        }

        int lca = -1;
        int maxW = 0;

        while (u != v) {
            if (depth[u] > depth[v]) {
                maxW = (maxW > maxWeight[u]) ? maxW : maxWeight[u];
                u = parent[u];
            } else {
                maxW = (maxW > maxWeight[v]) ? maxW : maxWeight[v];
                v = parent[v];
            }
        }

        result[q - 1] = maxW;

        free(parent);
        free(depth);
        free(maxWeight);
        free(visited);
        free(queue);
    }

    for (int i = 0; i < n; i++) {
        Edge* e = adj[i].head;
        while (e) {
            Edge* next = e->next;
            free(e);
            e = next;
        }
    }

    free(adj);

    return result;
}