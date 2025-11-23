int* gardenNoAdj(int n, int** paths, int pathsSize, int* pathsColSize, int* returnSize) {
    *returnSize = n;
    int* result = (int*)malloc(n * sizeof(int));

    // Adjacency list representation
    // adj[i][0] stores the count of neighbors for garden i
    // adj[i][1], adj[i][2], adj[i][3] store the actual neighbors
    // Since each garden has at most 3 adjacent gardens, we can use a fixed size array for neighbors.
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)calloc(4, sizeof(int)); // [count, neighbor1, neighbor2, neighbor3]
    }

    // Build adjacency list
    for (int i = 0; i < pathsSize; i++) {
        int u = paths[i][0] - 1; // Convert to 0-indexed
        int v = paths[i][1] - 1; // Convert to 0-indexed

        adj[u][++adj[u][0]] = v;
        adj[v][++adj[v][0]] = u;
    }

    // Color each garden
    for (int i = 0; i < n; i++) {
        int used_colors[5] = {0}; // Boolean array to mark used colors (1-indexed for colors 1-4)

        // Check colors of adjacent gardens that have already been colored
        for (int k = 1; k <= adj[i][0]; k++) { // Iterate through neighbors
            int neighbor = adj[i][k];
            if (result[neighbor] != 0) { // If neighbor is already colored (result is initialized to 0)
                used_colors[result[neighbor]] = 1;
            }
        }

        // Find the smallest available color (1 to 4)
        for (int color = 1; color <= 4; color++) {
            if (used_colors[color] == 0) { // If this color is not used by any colored neighbor
                result[i] = color;
                break; // Assign this color and move to the next garden
            }
        }
    }

    // Free allocated memory for adjacency list
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);

    return result;
}