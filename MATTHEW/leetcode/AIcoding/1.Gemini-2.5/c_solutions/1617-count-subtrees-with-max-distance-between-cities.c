#include <stdlib.h> // For malloc, free, calloc
#include <stdbool.h> // For bool
#include <string.h> // For memset

#define MAX_N 15

int adj[MAX_N][MAX_N];
int adj_counts[MAX_N];

int queue[MAX_N];
int q_front, q_rear;

void enqueue(int val) {
    queue[q_rear++] = val;
}

int dequeue() {
    return queue[q_front++];
}

bool is_q_empty() {
    return q_front == q_rear;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int* countSubgraphsForEachDiameter(int n, int** edges, int edgesSize, int* edgesColSize) {
    // Initialize adjacency list for the original graph
    for (int i = 0; i < n; i++) {
        adj_counts[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1; // Convert to 0-indexed
        int v = edges[i][1] - 1; // Convert to 0-indexed
        adj[u][adj_counts[u]++] = v;
        adj[v][adj_counts[v]++] = u;
    }

    // ans[d-1] will store the count for diameter d
    // Max possible diameter is n-1
    int* ans = (int*)calloc(n - 1, sizeof(int)); 

    // Iterate through all possible subsets of cities using a bitmask
    // A mask represents a subset: if the i-th bit is set, city i is in the subset.
    // We start from mask = 1 because an empty subset or a subset with one city
    // cannot form a subtree with a positive diameter.
    for (int mask = 1; mask < (1 << n); mask++) {
        int num_cities_in_subset = 0;
        int start_node = -1; // To find an arbitrary starting node for connectivity check

        for (int i = 0; i < n; i++) {
            if ((mask >> i) & 1) { // If city i is in the current subset
                num_cities_in_subset++;
                if (start_node == -1) {
                    start_node = i; // Pick the first city in the subset as start_node
                }
            }
        }

        // Subsets with less than 2 cities cannot have a positive diameter
        if (num_cities_in_subset < 2) {
            continue;
        }

        // --- Connectivity Check (BFS) ---
        // Determine if the selected cities form a connected component using only edges within the subset.
        bool visited_bfs[MAX_N];
        memset(visited_bfs, 0, sizeof(visited_bfs)); // Reset visited array

        q_front = 0;
        q_rear = 0;

        enqueue(start_node);
        visited_bfs[start_node] = true;
        int visited_count = 1;

        while (!is_q_empty()) {
            int u = dequeue();
            for (int i = 0; i < adj_counts[u]; i++) {
                int v = adj[u][i];
                // Check if neighbor 'v' is in the current subset (mask) and not yet visited
                if (((mask >> v) & 1) && !visited_bfs[v]) {
                    visited_bfs[v] = true;
                    visited_count++;
                    enqueue(v);
                }
            }
        }

        // If not all cities in the subset were reachable (i.e., not connected), skip this subset
        if (visited_count != num_cities_in_subset) {
            continue;
        }

        // --- Calculate Max Distance (Diameter) in the connected subtree ---
        // For a connected component, the diameter is the longest shortest path between any two nodes.
        // This can be found by performing a BFS from each node in the component
        // and taking the maximum distance found.
        int max_dist_for_current_subset = 0;

        for (int i = 0; i < n; i++) {
            if ((mask >> i) & 1) { // If city 'i' is in the current subset
                int dist[MAX_N];
                for (int k = 0; k < n; k++) {
                    dist[k] = -1; // Initialize distances to -1 (unvisited)
                }

                q_front = 0;
                q_rear = 0;

                enqueue(i);
                dist[i] = 0;
                int current_max_dist_from_i = 0;

                while (!is_q_empty()) {
                    int u_bfs = dequeue();
                    // Update the max distance found from the current BFS source 'i'
                    current_max_dist_from_i = max(current_max_dist_from_i, dist[u_bfs]);

                    for (int k = 0; k < adj_counts[u_bfs]; k++) {
                        int v_bfs = adj[u_bfs][k];
                        // Check if neighbor 'v_bfs' is in the current subset (mask) and not yet visited
                        if (((mask >> v_bfs) & 1) && dist[v_bfs] == -1) {
                            dist[v_bfs] = dist[u_bfs] + 1;
                            enqueue(v_bfs);
                        }
                    }
                }
                // Update the overall max distance for this subset
                max_dist_for_current_subset = max(max_dist_for_current_subset, current_max_dist_from_i);
            }
        }

        // Increment the count for this diameter
        // Diameters are 1-indexed in the problem description, so we use max_dist - 1 for 0-indexed array
        if (max_dist_for_current_subset > 0) {
            ans[max_dist_for_current_subset - 1]++;
        }
    }

    return ans;
}