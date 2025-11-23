#include <stdlib.h> // For malloc, free, calloc

int* findMinHeightTrees(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    // Base case: If there's only one node, it's the root of the MHT.
    if (n == 1) {
        *returnSize = 1;
        int* result = (int*)malloc(sizeof(int));
        result[0] = 0;
        return result;
    }

    // Allocate memory for degree array and adjacency list
    int* degree = (int*)calloc(n, sizeof(int));
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adj_current_sizes = (int*)calloc(n, sizeof(int)); // Used to track current size while building adj list

    // First pass: Count degrees for each node
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;
    }

    // Allocate memory for each node's adjacency list based on its degree
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(degree[i] * sizeof(int));
        adj_current_sizes[i] = 0; // Reset for populating neighbors
    }

    // Second pass: Populate adjacency lists
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_current_sizes[u]++] = v;
        adj[v][adj_current_sizes[v]++] = u;
    }

    // Initialize a queue for leaf nodes
    int* q = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    // Add all initial leaf nodes (degree 1) to the queue
    for (int i = 0; i < n; i++) {
        if (degree[i] == 1) {
            q[rear++] = i;
        }
    }

    int remaining_nodes = n;

    // Perform leaf removal until 1 or 2 nodes remain
    while (remaining_nodes > 2) {
        int level_size = rear - front; // Number of leaves in the current layer
        remaining_nodes -= level_size;

        for (int i = 0; i < level_size; i++) {
            int u = q[front++]; // Dequeue a leaf node

            // For each neighbor of the dequeued leaf
            for (int j = 0; j < adj_current_sizes[u]; j++) {
                int v = adj[u][j];
                degree[v]--; // Decrement neighbor's degree
                if (degree[v] == 1) { // If neighbor becomes a new leaf
                    q[rear++] = v; // Enqueue it
                }
            }
        }
    }

    // The remaining nodes in the queue are the roots of the MHTs
    *returnSize = rear - front;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = q[front++];
    }

    // Free allocated memory
    free(degree);
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adj_current_sizes);
    free(q);

    return result;
}