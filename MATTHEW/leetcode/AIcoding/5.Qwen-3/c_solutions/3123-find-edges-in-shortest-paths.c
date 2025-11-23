#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>

typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    Edge* edges;
    int edge_count;
} AdjList;

typedef struct {
    int node;
    int dist;
} DistNode;

int compare(const void* a, const void* b) {
    return ((DistNode*)a)->dist - ((DistNode*)b)->dist;
}

void dijkstra(int n, AdjList* adj, int start, int* dist) {
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[start] = 0;

    DistNode* pq = (DistNode*)malloc(n * sizeof(DistNode));
    int pq_size = 0;

    pq[pq_size++] = (DistNode){start, 0};

    while (pq_size > 0) {
        qsort(pq, pq_size, sizeof(DistNode), compare);
        DistNode current = pq[0];
        pq[0] = pq[--pq_size];

        int u = current.node;
        int d = current.dist;

        if (d > dist[u]) continue;

        for (int i = 0; i < adj[u].edge_count; i++) {
            Edge e = adj[u].edges[i];
            int v = e.node;
            int w = e.weight;
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                pq[pq_size++] = (DistNode){v, dist[v]};
            }
        }
    }

    free(pq);
}

bool isOnShortestPath(int n, AdjList* adj, int start, int end, int** result, int* returnSize, int* returnColumnSizes) {
    int* dist_start = (int*)malloc(n * sizeof(int));
    int* dist_end = (int*)malloc(n * sizeof(int));

    dijkstra(n, adj, start, dist_start);
    dijkstra(n, adj, end, dist_end);

    int count = 0;
    for (int u = 0; u < n; u++) {
        for (int i = 0; i < adj[u].edge_count; i++) {
            Edge e = adj[u].edges[i];
            int v = e.node;
            int w = e.weight;
            if (dist_start[u] + w + dist_end[v] == dist_start[end]) {
                count++;
            }
        }
    }

    *returnSize = count;
    *result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));

    int idx = 0;
    for (int u = 0; u < n; u++) {
        for (int i = 0; i < adj[u].edge_count; i++) {
            Edge e = adj[u].edges[i];
            int v = e.node;
            int w = e.weight;
            if (dist_start[u] + w + dist_end[v] == dist_start[end]) {
                (*result)[idx] = (int*)malloc(2 * sizeof(int));
                (*result)[idx][0] = u;
                (*result)[idx][1] = v;
                (*returnColumnSizes)[idx++] = 2;
            }
        }
    }

    free(dist_start);
    free(dist_end);
    return true;
}

int** findCriticalAndPseudoCriticalEdges(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize, int** returnColumnSizes) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].edge_count = 0;
        adj[i].edges = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        adj[u].edge_count++;
        adj[u].edges = (Edge*)realloc(adj[u].edges, adj[u].edge_count * sizeof(Edge));
        adj[u].edges[adj[u].edge_count - 1] = (Edge){v, w};

        adj[v].edge_count++;
        adj[v].edges = (Edge*)realloc(adj[v].edges, adj[v].edge_count * sizeof(Edge));
        adj[v].edges[adj[v].edge_count - 1] = (Edge){u, w};
    }

    int** result = NULL;
    isOnShortestPath(n, adj, 0, n - 1, &result, returnSize, returnColumnSizes);

    for (int i = 0; i < n; i++) {
        free(adj[i].edges);
    }
    free(adj);

    return result;
}