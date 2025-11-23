#include <stdbool.h>
#include <stdlib.h>

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    if (graphSize == 0) {
        return true;
    }

    // colors array: 0 = uncolored, 1 = color A, 2 = color B
    int* colors = (int*)calloc(graphSize, sizeof(int));
    if (colors == NULL) {
        return false; // Memory allocation failed
    }

    // Queue for BFS
    int* queue = (int*)malloc(graphSize * sizeof(int));
    if (queue == NULL) {
        free(colors);
        return false; // Memory allocation failed
    }
    int front = 0;
    int rear = 0;

    // Iterate through all nodes to handle disconnected components
    for (int i = 0; i < graphSize; ++i) {
        if (colors[i] == 0) { // If node i is uncolored, start a BFS from it
            colors[i] = 1; // Assign color A to the starting node
            queue[rear++] = i; // Enqueue the starting node

            while (front < rear) { // While the queue is not empty
                int u = queue[front++]; // Dequeue a node

                // Explore neighbors of u
                for (int j = 0; j < graphColSize[u]; ++j) {
                    int v = graph[u][j]; // Neighbor v

                    if (colors[v] == 0) { // If neighbor v is uncolored
                        colors[v] = 3 - colors[u]; // Assign the opposite color (1 -> 2, 2 -> 1)
                        queue[rear++] = v; // Enqueue v
                    } else if (colors[v] == colors[u]) { // If neighbor v has the same color as u
                        free(colors);
                        free(queue);
                        return false; // Not bipartite
                    }
                }
            }
        }
    }

    free(colors);
    free(queue);
    return true; // All nodes processed without conflicts, graph is bipartite
}