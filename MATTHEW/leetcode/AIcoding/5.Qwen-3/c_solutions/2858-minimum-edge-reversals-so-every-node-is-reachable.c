#include <stdio.h>
#include <stdlib.h>

typedef struct Edge {
    int to;
    int reversed;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} AdjList;

void addEdge(AdjList* list, int to, int reversed) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->edges = (Edge*)realloc(list->edges, list->capacity * sizeof(Edge));
    }
    list->edges[list->size++] = (Edge){to, reversed};
}

int dfs(int node, int parent, AdjList* adj, int* result) {
    int res = 0;
    for (int i = 0; i < adj[node].size; i++) {
        Edge e = adj[node].edges[i];
        if (e.to != parent) {
            res += dfs(e.to, node, adj, result);
            if (e.reversed) {
                res++;
            }
        }
    }
    *result = res;
    return res;
}

int dfs2(int node, int parent, AdjList* adj, int total, int* result) {
    int res = total;
    for (int i = 0; i < adj[node].size; i++) {
        Edge e = adj[node].edges[i];
        if (e.to != parent) {
            if (e.reversed) {
                res--;
            } else {
                res++;
            }
            dfs2(e.to, node, adj, res, result);
        }
    }
    *result = res;
    return res;
}

int minEdgeReversals(int n, int** edges, int edgesSize, int* edgesColSize) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].edges = NULL;
        adj[i].size = 0;
        adj[i].capacity = 1;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(&adj[u], v, 0);
        addEdge(&adj[v], u, 1);
    }

    int total = 0;
    dfs(0, -1, adj, &total);

    int result = 0;
    dfs2(0, -1, adj, total, &result);

    for (int i = 0; i < n; i++) {
        free(adj[i].edges);
    }
    free(adj);

    return result;
}