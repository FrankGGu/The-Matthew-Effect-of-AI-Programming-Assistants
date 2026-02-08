#include <stdlib.h> // For malloc, realloc, free
#include <string.h> // For memset (optional, can use loop)
#include <limits.h> // For INT_MAX

#define MAX_NODES 1000

int* adj[MAX_NODES];
int adj_sizes[MAX_NODES];
int adj_capacities[MAX_NODES];

int dist[MAX_NODES];
int parent[MAX_NODES];
int queue[MAX_NODES]; // Max N elements in queue

void add_edge_helper(int u, int v) {
    if (adj_sizes[u] == adj_capacities[u]) {
        // Double the capacity when needed
        adj_capacities[u] = (adj_capacities[u] == 0) ? 4 : adj_capacities[u] * 2;
        adj[u] = (int*)realloc(adj[u], adj_capacities[u] * sizeof(int));
    }
    adj[u][adj_sizes[u]++] = v;
}

int shortestCycle(int n, int** edges, int edgesSize, int* edgesColSize) {
    // Initialize adjacency list structures
    for (int i = 0; i < n; ++i) {
        adj[i] = NULL; // Important to initialize to NULL for realloc
        adj_sizes[i] = 0;
        adj_capacities[i] = 0;
    }

    // Build adjacency list for an undirected graph
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge_helper(u, v);
        add_edge_helper(v, u);
    }

    int min_cycle_len = INT_MAX;

    // Iterate through each node as a potential BFS source
    for (int i = 0; i < n; ++i) {
        // Initialize BFS arrays for the current source
        // memset(dist, -1, sizeof(int) * n); // Alternative to loop
        for (int j = 0; j < n; ++j) {
            dist[j] = -1; // -1 means unvisited
            parent[j] = -1;
        }

        int head = 0;
        int tail = -1; // Queue is empty

        // Start BFS from node i
        queue[++tail] = i;
        dist[i] = 0;

        while (head <= tail) {
            int u = queue[head++];

            for (int k = 0; k < adj_sizes[u]; ++k) {
                int v = adj[u][k];

                if (dist[v] == -1) { // v is unvisited
                    dist[v] = dist[u] + 1;
                    parent[v] = u;
                    queue[++tail] = v;
                } else if (v != parent[u]) { // v is visited and not the direct parent of u
                    // Found a cycle
                    // The length of the cycle is dist[u] + dist[v] + 1
                    // (distance from source to u) + (distance from source to v) + (edge u-v)
                    int current_cycle_len = dist[u] + dist[v] + 1;
                    if (current_cycle_len < min_cycle_len) {
                        min_cycle_len = current_cycle_len;
                    }
                }
            }
        }
    }

    // Free dynamically allocated memory for adjacency list
    for (int i = 0; i < n; ++i) {
        if (adj[i] != NULL) {
            free(adj[i]);
        }
    }

    return (min_cycle_len == INT_MAX) ? -1 : min_cycle_len;
}