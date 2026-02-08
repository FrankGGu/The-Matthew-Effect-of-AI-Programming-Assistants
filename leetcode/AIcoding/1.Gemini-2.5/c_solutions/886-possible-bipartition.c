#include <stdbool.h>
#include <stdlib.h>

bool bfs(int start_node, int n, int** adj, int* adjSizes, int* colors) {
    // Queue for BFS
    int* queue = (int*)malloc((n + 1) * sizeof(int));
    int head = 0;
    int tail = 0;

    // Start BFS from start_node
    queue[tail++] = start_node;
    colors[start_node] = 1; // Assign color 1 to the starting node

    while (head < tail) {
        int u = queue[head++];

        // Iterate through all neighbors of u
        for (int i = 0; i < adjSizes[u]; i++) {
            int v = adj[u][i];

            if (colors[v] == 0) { // If neighbor v is uncolored
                colors[v] = 3 - colors[u]; // Assign the opposite color (1 -> 2, 2 -> 1)
                queue[tail++] = v; // Add v to the queue
            } else if (colors[v] == colors[u]) { // If neighbor v has the same color as u
                free(queue); // Conflict found, graph is not bipartitionable
                return false;
            }
        }
    }
    free(queue); // No conflict found in this connected component
    return true;
}

bool possibleBipartition(int n, int** dislikes, int dislikesSize, int* dislikesColSize) {
    // Adjacency list representation of the graph
    int** adj = (int**)malloc((n + 1) * sizeof(int*));
    int* adjSizes = (int*)calloc((n + 1), sizeof(int)); // Stores current number of neighbors for each node

    // First pass: Count degrees to allocate memory precisely for adjacency lists
    int* degree = (int*)calloc((n + 1), sizeof(int));
    for (int i = 0; i < dislikesSize; i++) {
        degree[dislikes[i][0]]++;
        degree[dislikes[i][1]]++;
    }

    // Allocate memory for each adjacency list
    for (int i = 1; i <= n; i++) {
        adj[i] = (int*)malloc(degree[i] * sizeof(int));
        adjSizes[i] = 0; // Reset for actual population
    }
    free(degree); // Degree array no longer needed

    // Second pass: Populate the adjacency list
    for (int i = 0; i < dislikesSize; i++) {
        int u = dislikes[i][0];
        int v = dislikes[i][1];
        adj[u][adjSizes[u]++] = v;
        adj[v][adjSizes[v]++] = u;
    }

    // Colors array: 0 = uncolored, 1 = color A, 2 = color B
    int* colors = (int*)calloc((n + 1), sizeof(int));

    // Iterate through all nodes to handle disconnected components
    for (int i = 1; i <= n; i++) {
        if (colors[i] == 0) { // If node i is uncolored, start a BFS from it
            if (!bfs(i, n, adj, adjSizes, colors)) {
                // If BFS finds a conflict, clean up memory and return false
                for (int j = 1; j <= n; j++) {
                    free(adj[j]);
                }
                free(adj);
                free(adjSizes);
                free(colors);
                return false;
            }
        }
    }

    // If all components are successfully colored without conflict, clean up memory and return true
    for (int i = 1; i <= n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSizes);
    free(colors);

    return true;
}