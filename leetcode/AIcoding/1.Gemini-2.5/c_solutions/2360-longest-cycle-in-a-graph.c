#include <stdlib.h> // For calloc, free

static int max(int a, int b) {
    return a > b ? a : b;
}

int longestCycle(int* edges, int edgesSize) {
    int n = edgesSize;

    // visited array states:
    // 0: unvisited
    // 1: currently visiting (part of the current DFS path being explored)
    // 2: visited and processed (part of a finished path or cycle, or a path that merged into an already processed component)
    int* visited = (int*) calloc(n, sizeof(int));

    // dist array: stores the distance of a node from the start of the current DFS path.
    // This value is only meaningful when a node is in 'visited' state 1.
    int* dist = (int*) calloc(n, sizeof(int));

    int max_cycle_len = -1;

    for (int i = 0; i < n; ++i) {
        if (visited[i] == 0) { // If node i hasn't been part of any previous path/cycle
            int current_node = i;
            int current_dist = 0;

            // Traverse the path starting from i
            // The loop continues as long as we are on a valid node and it hasn't been globally visited yet.
            while (current_node != -1 && visited[current_node] == 0) {
                visited[current_node] = 1;      // Mark as currently visiting
                dist[current_node] = current_dist; // Store its distance from the start of this DFS

                current_node = edges[current_node];
                current_dist++;
            }

            // After the loop, 'current_node' is either:
            // 1. -1 (end of a path)
            // 2. A node with visited[current_node] == 1 (cycle detected in the current path)
            // 3. A node with visited[current_node] == 2 (path merged into an already processed component)

            // If current_node is not -1 AND it was marked as 'currently visiting' (state 1),
            // it means we found a cycle in the current path.
            if (current_node != -1 && visited[current_node] == 1) {
                int cycle_len = current_dist - dist[current_node];
                max_cycle_len = max(max_cycle_len, cycle_len);
            }

            // Mark all nodes in the path that just finished as fully processed (state 2).
            // This prevents re-processing them as start nodes for future DFS and correctly handles
            // paths that merge into already processed components.
            // We iterate from the original starting node 'i' again to mark the entire path.
            int temp_node = i;
            while (temp_node != -1 && visited[temp_node] != 2) {
                visited[temp_node] = 2; // Mark as fully processed
                temp_node = edges[temp_node];
            }
        }
    }

    free(visited);
    free(dist);

    return max_cycle_len;
}