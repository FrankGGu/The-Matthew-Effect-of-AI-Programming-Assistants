#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* to;
    int* weight;
    int size;
} Edge;

typedef struct {
    Edge* edges;
    int num_nodes;
} Graph;

Graph* create_graph(int n) {
    Graph* g = (Graph*)malloc(sizeof(Graph));
    g->num_nodes = n;
    g->edges = (Edge*)malloc(n * sizeof(Edge));
    for (int i = 0; i < n; i++) {
        g->edges[i].to = NULL;
        g->edges[i].weight = NULL;
        g->edges[i].size = 0;
    }
    return g;
}

void add_edge(Graph* g, int u, int v, int w) {
    int len = g->edges[u].size;
    g->edges[u].to = (int*)realloc(g->edges[u].to, (len + 1) * sizeof(int));
    g->edges[u].weight = (int*)realloc(g->edges[u].weight, (len + 1) * sizeof(int));
    g->edges[u].to[len] = v;
    g->edges[u].weight[len] = w;
    g->edges[u].size++;
}

int dijkstra(Graph* g, int start, int end, int* dist) {
    int* visited = (int*)calloc(g->num_nodes, sizeof(int));
    for (int i = 0; i < g->num_nodes; i++) dist[i] = INT_MAX;
    dist[start] = 0;
    for (int i = 0; i < g->num_nodes; i++) {
        int u = -1;
        for (int j = 0; j < g->num_nodes; j++) {
            if (!visited[j] && (u == -1 || dist[j] < dist[u])) u = j;
        }
        if (u == -1) break;
        visited[u] = 1;
        for (int j = 0; j < g->edges[u].size; j++) {
            int v = g->edges[u].to[j];
            int w = g->edges[u].weight[j];
            if (dist[v] > dist[u] + w) dist[v] = dist[u] + w;
        }
    }
    free(visited);
    return dist[end];
}

int* modifiedGraphEdges(int n, int** edges, int edgesSize, int* edgesColSize, int s, int e, int k, int* returnSize) {
    Graph* g = create_graph(n);
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        add_edge(g, u, v, w);
        add_edge(g, v, u, w);
    }

    int* dist = (int*)malloc(n * sizeof(int));
    dijkstra(g, s, e, dist);
    int original_dist = dist[e];

    if (original_dist > k) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(edgesSize * sizeof(int));
    *returnSize = edgesSize;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        if (w != -1) {
            result[i] = w;
            continue;
        }

        int new_w = k - (dist[u] - dist[v]);
        if (new_w < 0) new_w = 0;
        result[i] = new_w;
        add_edge(g, u, v, new_w);
        add_edge(g, v, u, new_w);
    }

    free(dist);
    return result;
}