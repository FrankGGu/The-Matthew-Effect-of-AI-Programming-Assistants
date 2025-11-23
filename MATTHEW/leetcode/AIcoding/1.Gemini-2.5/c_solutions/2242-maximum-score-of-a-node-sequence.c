#include <stdlib.h>
#include <string.h> // For memset

typedef struct {
    int score;
    int id;
} Neighbor;

int compareNeighbors(const void *a, const void *b) {
    return ((Neighbor *)b)->score - ((Neighbor *)a)->score;
}

#define MAX_NODES 100000
#define K_TOP_NEIGHBORS 3 

int degree[MAX_NODES]; // Stores the degree of each node
Neighbor all_neighbors[2 * MAX_NODES]; // Stores all neighbor entries in a flat array (max 2*M entries)
int adj_start_idx[MAX_NODES]; // Stores the starting index for each node's neighbors in `all_neighbors`
int adj_current_offset[MAX_NODES]; // Used during graph construction to track current position for adding neighbors

Neighbor final_adj[MAX_NODES][K_TOP_NEIGHBORS];
int final_adj_counts[MAX_NODES]; // Number of actual neighbors stored in final_adj for each node

int maximumScore(int* scores, int scoresSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = scoresSize;
    int max_score = -1;

    // --- Step 1: Initialize arrays and count degrees ---
    memset(degree, 0, sizeof(int) * n);
    memset(final_adj_counts, 0, sizeof(int) * n);

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;
    }

    // --- Step 2: Calculate start indices for each node's neighbors in `all_neighbors` ---
    // This allows storing all neighbors contiguously in a single array.
    if (n > 0) {
        adj_start_idx[0] = 0;
        for (int i = 1; i < n; i++) {
            adj_start_idx[i] = adj_start_idx[i-1] + degree[i-1];
        }
    }
    // Initialize current offsets to 0 for populating
    memset(adj_current_offset, 0, sizeof(int) * n);

    // --- Step 3: Populate `all_neighbors` array ---
    // Add neighbors for each edge in both directions.
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        // Add v to u's neighbors
        int u_idx = adj_start_idx[u] + adj_current_offset[u];
        all_neighbors[u_idx].score = scores[v];
        all_neighbors[u_idx].id = v;
        adj_current_offset[u]++;

        // Add u to v's neighbors
        int v_idx = adj_start_idx[v] + adj_current_offset[v];
        all_neighbors[v_idx].score = scores[u];
        all_neighbors[v_idx].id = u;
        adj_current_offset[v]++;
    }

    // --- Step 4: Sort segments of `all_neighbors` and extract top K for `final_adj` ---
    // For each node, sort its neighbors by score and keep only the top K_TOP_NEIGHBORS.
    for (int i = 0; i < n; i++) {
        if (degree[i] > 0) {
            // Sort the segment of all_neighbors corresponding to node i
            qsort(&all_neighbors[adj_start_idx[i]], degree[i], sizeof(Neighbor), compareNeighbors);

            // Copy top K_TOP_NEIGHBORS to final_adj
            final_adj_counts[i] = (degree[i] < K_TOP_NEIGHBORS) ? degree[i] : K_TOP_NEIGHBORS;
            for (int k = 0; k < final_adj_counts[i]; k++) {
                final_adj[i][k] = all_neighbors[adj_start_idx[i] + k];
            }
        }
    }

    // --- Step 5: Iterate over all edges (b, c) and find the maximum score ---
    // For each edge (b, c), try to find suitable 'a' and 'd' from their top K neighbors.
    for (int i = 0; i < edgesSize; i++) {
        int b = edges[i][0];
        int c = edges[i][1];

        // Iterate through potential 'a' nodes (top K neighbors of b)
        for (int j = 0; j < final_adj_counts[b]; j++) {
            int a = final_adj[b][j].id;
            if (a == c) { // 'a' must not be 'c'
                continue;
            }

            // Iterate through potential 'd' nodes (top K neighbors of c)
            for (int k = 0; k < final_adj_counts[c]; k++) {
                int d = final_adj[c][k].id;
                // 'd' must not be 'b' and 'd' must not be 'a'
                if (d == b || d == a) { 
                    continue;
                }

                // Valid sequence a-b-c-d found
                int current_score = scores[a] + scores[b] + scores[c] + scores[d];
                if (current_score > max_score) {
                    max_score = current_score;
                }
            }
        }
    }

    return max_score;
}