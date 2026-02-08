#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    int distance;
} Edge;

typedef struct {
    Edge* edges;
    int edge_count;
} AdjList;

int compare(const void* a, const void* b) {
    return ((Edge*)a)->distance - ((Edge*)b)->distance;
}

int dijkstra(int n, int** adj, int source, int threshold) {
    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[source] = 0;

    Edge* heap = (Edge*)malloc(n * sizeof(Edge));
    int heap_size = 0;

    heap[heap_size++] = (Edge){source, 0};

    while (heap_size > 0) {
        qsort(heap, heap_size, sizeof(Edge), compare);
        Edge current = heap[0];
        for (int i = 0; i < heap_size - 1; i++) {
            heap[i] = heap[i + 1];
        }
        heap_size--;

        if (current.distance > threshold) continue;

        for (int i = 0; i < n; i++) {
            if (adj[current.node][i] != 0 && dist[i] > dist[current.node] + adj[current.node][i]) {
                dist[i] = dist[current.node] + adj[current.node][i];
                heap[heap_size++] = (Edge){i, dist[i]};
            }
        }
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] <= threshold) count++;
    }

    free(dist);
    free(heap);
    return count;
}

int findTheCity(int n, int** edges, int edgesSize, int* edgesColSize, int distanceThreshold) {
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        adj[u][v] = w;
        adj[v][u] = w;
    }

    int min_neighbors = n;
    int result_city = 0;

    for (int i = 0; i < n; i++) {
        int neighbors = dijkstra(n, adj, i, distanceThreshold);
        if (neighbors < min_neighbors) {
            min_neighbors = neighbors;
            result_city = i;
        } else if (neighbors == min_neighbors && i < result_city) {
            result_city = i;
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);

    return result_city;
}