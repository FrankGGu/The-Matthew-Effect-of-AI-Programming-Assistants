#include <stdlib.h>
#include <stdbool.h>

int dfs(int u, int n, int** adj, int* adjSizes, bool* visited) {
    visited[u] = true;
    int current_component_size = 1;

    for (int i = 0; i < adjSizes[u]; i++) {
        int v = adj[u][i];
        if (!visited[v]) {
            current_component_size += dfs(v, n, adj, adjSizes, visited);
        }
    }
    return current_component_size;
}

long long countPairs(int n, int** edges, int edgesSize, int* edgesColSize) {
    // 1. Build adjacency list
    // First, count degrees of each node to pre-allocate memory efficiently
    int* degree = (int*)calloc(n, sizeof(int)); // calloc initializes memory to zero

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSizes = (int*)calloc(n, sizeof(int)); // Used as current index during population, then holds actual size

    // Allocate memory for each adjacency list based on calculated degrees
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(degree[i] * sizeof(int));
    }

    // Populate adjacency list
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        adj[u][adjSizes[u]++] = v;
        adj[v][adjSizes[v]++] = u;
    }

    // The degree array is no longer needed after adjacency list construction
    free(degree);

    // 2. Find connected components and their sizes using DFS
    bool* visited = (bool*)calloc(n, sizeof(bool)); // Initialize all nodes as not visited

    long long unreachable_pairs = 0;
    long long nodes_processed_so_far = 0;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            // Found a new connected component
            int component_size = dfs(i, n, adj, adjSizes, visited);

            // Calculate unreachable pairs:
            // Each node in the current component can form an unreachable pair with any node
            // that is not in this component AND has not been processed yet (i.e., in subsequent components).
            // (n - nodes_processed_so_far - component_size) gives the count of such nodes.
            unreachable_pairs += (long long)component_size * (n - nodes_processed_so_far - component_size);

            // Add the size of the current component to the count of processed nodes
            nodes_processed_so_far += component_size;
        }
    }

    // 3. Free all dynamically allocated memory
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSizes);
    free(visited);

    return unreachable_pairs;
}