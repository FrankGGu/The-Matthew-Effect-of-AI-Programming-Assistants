#include <stdlib.h> // For malloc, free, calloc

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int networkBecomesIdle(int n, int** edges, int edgesSize, int* edgesColSize, int* patience, int patienceSize) {
    // 1. Build adjacency list
    // adj[i] will store a list of neighbors for server i
    // adj_sizes[i] will store the number of neighbors for server i
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adj_sizes = (int*)calloc(n, sizeof(int));
    int* adj_capacities = (int*)calloc(n, sizeof(int));

    // First pass to count degrees for initial allocation
    for (int i = 0; i < edgesSize; ++i) {
        adj_sizes[edges[i][0]]++;
        adj_sizes[edges[i][1]]++;
    }

    // Allocate memory for each adjacency list based on degree
    for (int i = 0; i < n; ++i) {
        adj_capacities[i] = adj_sizes[i]; // Capacity is initially degree
        adj[i] = (int*)malloc(adj_capacities[i] * sizeof(int));
        adj_sizes[i] = 0; // Reset sizes to 0 for filling
    }

    // Second pass to fill adjacency lists
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_sizes[u]++] = v;
        adj[v][adj_sizes[v]++] = u;
    }

    // 2. BFS to find shortest distances from server 0 to all other servers
    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        dist[i] = -1; // -1 indicates unvisited
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0;
    int tail = 0;

    queue[tail++] = 0;
    dist[0] = 0;

    while (head < tail) {
        int u = queue[head++];
        for (int i = 0; i < adj_sizes[u]; ++i) {
            int v = adj[u][i];
            if (dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[tail++] = v;
            }
        }
    }

    // 3. Calculate network idle time
    int max_idle_time = 0;

    for (int i = 1; i < n; ++i) { // Iterate through data servers (i > 0)
        int d_i = dist[i]; // Shortest path from i to 0
        int p_i = patience[i]; // Patience for server i

        int round_trip_time = 2 * d_i;
        int last_sent_time_i;

        if (round_trip_time <= p_i) {
            last_sent_time_i = 0;
        } else {
            // Number of retransmissions = floor((round_trip_time - 1) / p_i)
            // Last sent time = number of retransmissions * p_i
            last_sent_time_i = ((round_trip_time - 1) / p_i) * p_i;
        }

        // Time when the last package from server i arrives at server 0
        int last_package_arrival_time = last_sent_time_i + d_i;

        // Time when server i becomes idle (stops sending)
        // This is the time of its last send plus its patience duration
        int server_idle_finish_time = last_sent_time_i + p_i;

        // The network must be busy at least until the later of these two times for server i
        int current_server_max_time = max(last_package_arrival_time, server_idle_finish_time);

        max_idle_time = max(max_idle_time, current_server_max_time);
    }

    // The network becomes idle at the earliest second AFTER all conditions are met.
    // So, if the last event is at time T, the network is idle at T+1.
    int result = max_idle_time + 1;

    // Free allocated memory
    for (int i = 0; i < n; ++i) {
        free(adj[i]);
    }
    free(adj);
    free(adj_sizes);
    free(adj_capacities);
    free(dist);
    free(queue);

    return result;
}