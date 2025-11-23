#include <stdlib.h>
#include <limits.h> // For INT_MAX

typedef struct {
    int node;
    int time;
} QueueNode;

typedef struct {
    int* neighbors;
    int count;
    int capacity;
} AdjList;

void addEdge(AdjList* adj, int u, int v) {
    if (adj[u].count == adj[u].capacity) {
        adj[u].capacity = adj[u].capacity == 0 ? 4 : adj[u].capacity * 2;
        adj[u].neighbors = (int*)realloc(adj[u].neighbors, adj[u].capacity * sizeof(int));
    }
    adj[u].neighbors[adj[u].count++] = v;
}

void free_resources(AdjList* adj, int n, int** dist, QueueNode* queue) {
    for (int i = 0; i <= n; ++i) {
        free(adj[i].neighbors);
        free(dist[i]);
    }
    free(adj);
    free(dist);
    free(queue);
}

int secondMinimum(int n, int** edges, int edgesSize, int* edgesColSize, int time, int change) {
    // Adjacency list initialization
    AdjList* adj = (AdjList*)calloc(n + 1, sizeof(AdjList));
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(adj, u, v);
        addEdge(adj, v, u); // Graph is undirected
    }

    // dist[node][0] stores the minimum time to reach node
    // dist[node][1] stores the second minimum time to reach node
    int** dist = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; ++i) {
        dist[i] = (int*)malloc(2 * sizeof(int));
        dist[i][0] = INT_MAX;
        dist[i][1] = INT_MAX;
    }

    // BFS queue
    // Max queue size can be N * 2 (for each node, min1 and min2)
    QueueNode* queue = (QueueNode*)malloc((n * 2) * sizeof(QueueNode));
    int head = 0, tail = 0;

    // Start BFS from node 1 at time 0
    dist[1][0] = 0;
    queue[tail++] = (QueueNode){.node = 1, .time = 0};

    while (head < tail) {
        QueueNode current = queue[head++];
        int u = current.node;
        int currentTimeAtU = current.time;

        // If we extracted the second minimum time for node n, we are done.
        // Since BFS explores in non-decreasing time, this must be the final second minimum.
        if (u == n && currentTimeAtU == dist[n][1]) {
            int result = dist[n][1];
            free_resources(adj, n, dist, queue);
            return result;
        }

        // Calculate time to depart from u considering traffic lights
        int numIntervals = currentTimeAtU / change;
        int timeToDepartU = currentTimeAtU;
        if (numIntervals % 2 == 1) { // Red light, wait for green
            timeToDepartU = (numIntervals + 1) * change;
        }

        int timeToReachNeighbor = timeToDepartU + time;

        // Explore neighbors
        for (int i = 0; i < adj[u].count; ++i) {
            int v = adj[u].neighbors[i];

            if (timeToReachNeighbor < dist[v][0]) {
                dist[v][1] = dist[v][0]; // Move first min to second min
                dist[v][0] = timeToReachNeighbor; // Update first min
                queue[tail++] = (QueueNode){.node = v, .time = timeToReachNeighbor};
            } else if (timeToReachNeighbor > dist[v][0] && timeToReachNeighbor < dist[v][1]) {
                dist[v][1] = timeToReachNeighbor; // Update second min
                queue[tail++] = (QueueNode){.node = v, .time = timeToReachNeighbor};
            }
        }
    }

    // This part should ideally not be reached if a second minimum path always exists and is found.
    // The problem guarantees a path, and the BFS logic ensures the second minimum will be extracted.
    // However, as a fallback, return dist[n][1] and free resources.
    int result = dist[n][1];
    free_resources(adj, n, dist, queue);
    return result;
}