#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x, y, side;
} Square;

bool doOverlap(Square s1, Square s2) {
    // Check if one square is entirely to the right of the other
    if (s1.x >= s2.x + s2.side || s2.x >= s1.x + s1.side) {
        return false;
    }

    // Check if one square is entirely above the other (assuming y increases upwards)
    if (s1.y >= s2.y + s2.side || s2.y >= s1.y + s1.side) {
        return false;
    }

    return true;
}

bool separateSquaresII(int** squares, int squaresSize, int* squaresColSize) {
    if (squaresSize <= 1) {
        return true; // Trivial case: 0 or 1 square can always be separated
    }

    // Convert input int** to Square struct array for easier handling
    Square* squareObjs = (Square*)malloc(squaresSize * sizeof(Square));
    if (!squareObjs) {
        return false; // Allocation failure
    }

    for (int i = 0; i < squaresSize; i++) {
        squareObjs[i].x = squares[i][0];
        squareObjs[i].y = squares[i][1];
        squareObjs[i].side = squares[i][2];
    }

    // Build adjacency list for overlap graph
    int** adj = (int**)malloc(squaresSize * sizeof(int*));
    int* adjCounts = (int*)calloc(squaresSize, sizeof(int)); // Stores current count of neighbors
    int* adjCapacities = (int*)malloc(squaresSize * sizeof(int)); // Stores allocated capacity

    if (!adj || !adjCounts || !adjCapacities) {
        free(squareObjs);
        free(adj);
        free(adjCounts);
        free(adjCapacities);
        return false; // Allocation failure
    }

    // Initialize capacities and allocate initial memory for adjacency lists
    for (int i = 0; i < squaresSize; i++) {
        adjCapacities[i] = 4; // Start with a small capacity
        adj[i] = (int*)malloc(adjCapacities[i] * sizeof(int));
        if (!adj[i]) {
            // Cleanup previously allocated adj[k]
            for (int k = 0; k < i; k++) free(adj[k]);
            free(squareObjs);
            free(adj);
            free(adjCounts);
            free(adjCapacities);
            return false; // Allocation failure
        }
    }

    // Populate adjacency list based on overlaps
    for (int i = 0; i < squaresSize; i++) {
        for (int j = i + 1; j < squaresSize; j++) {
            if (doOverlap(squareObjs[i], squareObjs[j])) {
                // Add j to i's adjacency list
                if (adjCounts[i] == adjCapacities[i]) {
                    adjCapacities[i] *= 2;
                    adj[i] = (int*)realloc(adj[i], adjCapacities[i] * sizeof(int));
                    // In competitive programming, realloc failure is often not explicitly handled
                    // If it fails, behavior is undefined or program crashes.
                }
                adj[i][adjCounts[i]++] = j;

                // Add i to j's adjacency list
                if (adjCounts[j] == adjCapacities[j]) {
                    adjCapacities[j] *= 2;
                    adj[j] = (int*)realloc(adj[j], adjCapacities[j] * sizeof(int));
                }
                adj[j][adjCounts[j]++] = i;
            }
        }
    }

    // Bipartite check using BFS
    int* colors = (int*)calloc(squaresSize, sizeof(int)); // 0: uncolored, 1: color A, 2: color B
    if (!colors) {
        // Cleanup all allocations before returning
        for (int i = 0; i < squaresSize; i++) free(adj[i]);
        free(adj);
        free(adjCounts);
        free(adjCapacities);
        free(squareObjs);
        return false; // Allocation failure
    }

    int* queue = (int*)malloc(squaresSize * sizeof(int));
    if (!queue) {
        // Cleanup all allocations before returning
        for (int i = 0; i < squaresSize; i++) free(adj[i]);
        free(adj);
        free(adjCounts);
        free(adjCapacities);
        free(squareObjs);
        free(colors);
        return false; // Allocation failure
    }
    int head = 0, tail = 0;
    bool isBipartite = true;

    for (int i = 0; i < squaresSize; i++) {
        if (colors[i] == 0) { // If uncolored, start BFS from this node
            colors[i] = 1; // Assign first color
            queue[tail++] = i;

            while (head < tail) {
                int u = queue[head++];

                for (int k = 0; k < adjCounts[u]; k++) {
                    int v = adj[u][k];
                    if (colors[v] == 0) { // If neighbor is uncolored
                        colors[v] = 3 - colors[u]; // Assign opposite color (1 -> 2, 2 -> 1)
                        queue[tail++] = v;
                    } else if (colors[v] == colors[u]) { // If neighbor has the same color
                        isBipartite = false; // Not bipartite
                        break;
                    }
                }
                if (!isBipartite) break;
            }
        }
        if (!isBipartite) break;
    }

    // Cleanup allocated memory
    for (int i = 0; i < squaresSize; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjCounts);
    free(adjCapacities);
    free(squareObjs);
    free(colors);
    free(queue);

    return isBipartite;
}