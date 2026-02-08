#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    Edge *edges;
    int edge_count;
} AdjList;

int compare(const void *a, const void *b) {
    return ((Edge *)a)->weight - ((Edge *)b)->weight;
}

int dfs(int node, int end, int *visited, int *dist, AdjList *adj, int *result) {
    if (node == end) {
        return 1;
    }
    if (visited[node]) {
        return 0;
    }
    visited[node] = 1;
    int count = 0;
    for (int i = 0; i < adj[node].edge_count; i++) {
        Edge e = adj[node].edges[i];
        if (dist[e.node] < dist[node]) {
            count += dfs(e.node, end, visited, dist, adj, result);
        }
    }
    visited[node] = 0;
    return count;
}

int cmpfunc(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int numRestrictedPaths(int **edges, int edgesSize, int *edgesColSize, int n, int s, int e) {
    AdjList adj[n];
    for (int i = 0; i < n; i++) {
        adj[i].edge_count = 0;
        adj[i].edges = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        int w = edges[i][2];
        Edge e1 = {v, w};
        Edge e2 = {u, w};

        adj[u].edges = realloc(adj[u].edges, (adj[u].edge_count + 1) * sizeof(Edge));
        adj[u].edges[adj[u].edge_count++] = e1;

        adj[v].edges = realloc(adj[v].edges, (adj[v].edge_count + 1) * sizeof(Edge));
        adj[v].edges[adj[v].edge_count++] = e2;
    }

    int *dist = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[s] = 0;

    int *heap = (int *)malloc(n * sizeof(int));
    int heap_size = 0;

    heap[heap_size++] = s;
    while (heap_size > 0) {
        int u = heap[0];
        for (int i = 0; i < adj[u].edge_count; i++) {
            Edge e = adj[u].edges[i];
            if (dist[e.node] > dist[u] + e.weight) {
                dist[e.node] = dist[u] + e.weight;
                int j = heap_size++;
                while (j > 0 && dist[heap[(j - 1) / 2]] > dist[heap[j]]) {
                    int temp = heap[(j - 1) / 2];
                    heap[(j - 1) / 2] = heap[j];
                    heap[j] = temp;
                    j = (j - 1) / 2;
                }
            }
        }

        int min_node = heap[0];
        for (int i = 0; i < heap_size - 1; i++) {
            heap[i] = heap[i + 1];
        }
        heap_size--;
    }

    int *nodes = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        nodes[i] = i;
    }
    qsort(nodes, n, sizeof(int), cmpfunc);

    int *dp = (int *)malloc(n * sizeof(int));
    dp[s] = 1;

    for (int i = 0; i < n; i++) {
        int u = nodes[i];
        if (u == s) continue;
        for (int j = 0; j < adj[u].edge_count; j++) {
            Edge e = adj[u].edges[j];
            if (dist[e.node] < dist[u]) {
                dp[u] += dp[e.node];
            }
        }
    }

    int result = dp[e];
    free(dist);
    free(heap);
    free(nodes);
    free(dp);
    for (int i = 0; i < n; i++) {
        free(adj[i].edges);
    }
    return result;
}