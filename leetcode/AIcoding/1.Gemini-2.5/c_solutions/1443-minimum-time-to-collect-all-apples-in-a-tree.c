#include <stdbool.h>
#include <stdlib.h>

bool dfs(int u, int p, int n, int** adj, int* adjSizes, bool* hasApple, int* total_time) {
    bool apple_in_subtree = hasApple[u];

    for (int i = 0; i < adjSizes[u]; i++) {
        int v = adj[u][i];
        if (v == p) {
            continue;
        }
        if (dfs(v, u, n, adj, adjSizes, hasApple, total_time)) {
            *total_time += 2; // Add 2 for traversing edge u-v and v-u
            apple_in_subtree = true; // Propagate up that an apple was found in this branch
        }
    }
    return apple_in_subtree;
}

int minTime(int n, int** edges, int edgesSize, int* edgesColSize, bool* hasApple) {
    // Build adjacency list
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSizes = (int*)calloc(n, sizeof(int)); // Stores current size of each adj list

    // First pass to count degrees for each node
    for (int i = 0; i < edgesSize; i++) {
        adjSizes[edges[i][0]]++;
        adjSizes[edges[i][1]]++;
    }

    // Allocate memory for each adjacency list
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(adjSizes[i] * sizeof(int));
    }

    // Second pass to fill adjacency lists
    int* current_indices = (int*)calloc(n, sizeof(int)); // To track current fill position for each node
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][current_indices[u]++] = v;
        adj[v][current_indices[v]++] = u;
    }

    int total_time = 0;
    // Start DFS from node 0 (root) with parent -1
    dfs(0, -1, n, adj, adjSizes, hasApple, &total_time);

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSizes);
    free(current_indices);

    return total_time;
}