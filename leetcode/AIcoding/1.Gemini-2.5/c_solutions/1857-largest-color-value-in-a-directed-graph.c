#include <stdlib.h> // For malloc, free
#include <string.h> // For strlen

#define MAX_NODES 100005
#define MAX_EDGES 100005
#define NUM_COLORS 26 // 'a' through 'z'

int* adj[MAX_NODES];
int adj_counts[MAX_NODES];
int adj_current_indices[MAX_NODES];

int in_degree[MAX_NODES];

int dp[MAX_NODES][NUM_COLORS];

int queue[MAX_NODES];
int q_head, q_tail;

void init_graph(int n, int** edges, int edgesSize) {
    // Reset counts and DP table for all nodes
    for (int i = 0; i < n; i++) {
        adj_counts[i] = 0;
        in_degree[i] = 0;
        for (int j = 0; j < NUM_COLORS; j++) {
            dp[i][j] = 0;
        }
    }

    // First pass over edges to count out-degrees and in-degrees
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj_counts[u]++; // Count out-degree for u
        in_degree[v]++;  // Count in-degree for v
    }

    // Allocate memory for adjacency lists based on counted out-degrees
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(sizeof(int) * adj_counts[i]);
        adj_current_indices[i] = 0; // Reset for the second pass (population)
    }

    // Second pass over edges to populate adjacency lists
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_current_indices[u]++] = v; // Add v to u's adjacency list
    }

    // Initialize queue pointers
    q_head = 0;
    q_tail = 0;
}

void free_graph(int n) {
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
}

int largestPathValue(char* colors, int** edges, int edgesSize, int* edgesColSize) {
    int n = strlen(colors);
    if (n == 0) {
        return 0;
    }

    // Initialize graph structures
    init_graph(n, edges, edgesSize);

    int max_val = 0;

    // Initialize DP table and populate the queue with nodes having an in-degree of 0
    for (int i = 0; i < n; i++) {
        // A path consisting of only node 'i' has a count of 1 for its own color
        dp[i][colors[i] - 'a'] = 1;
        // Update global max_val
        if (dp[i][colors[i] - 'a'] > max_val) {
            max_val = dp[i][colors[i] - 'a'];
        }
        // If a node has no incoming edges, add it to the queue
        if (in_degree[i] == 0) {
            queue[q_tail++] = i;
        }
    }

    int nodes_processed = 0; // Counter for nodes processed in topological sort
    // Process nodes in topological order
    while (q_head < q_tail) {
        int u = queue[q_head++]; // Dequeue node u
        nodes_processed++;       // Increment processed nodes count

        // Iterate over all neighbors v of u
        for (int i = 0; i < adj_counts[u]; i++) {
            int v = adj[u][i];

            // Update DP values for neighbor v
            for (int c = 0; c < NUM_COLORS; c++) {
                int current_color_count = dp[u][c]; // Max count of color 'c' in path ending at 'u'
                // If node 'v' has color 'c', increment the count
                if (c == (colors[v] - 'a')) {
                    current_color_count++;
                }
                // If this new path to 'v' yields a higher count for color 'c', update dp[v][c]
                if (current_color_count > dp[v][c]) {
                    dp[v][c] = current_color_count;
                    // Update global max_val if a new maximum is found
                    if (dp[v][c] > max_val) {
                        max_val = dp[v][c];
                    }
                }
            }

            // Decrement in-degree of v. If it becomes 0, add v to the queue.
            in_degree[v]--;
            if (in_degree[v] == 0) {
                queue[q_tail++] = v;
            }
        }
    }

    // Free dynamically allocated memory for adjacency lists
    free_graph(n);

    // If not all nodes were processed, a cycle exists in the graph
    if (nodes_processed < n) {
        return -1;
    } else {
        return max_val;
    }
}