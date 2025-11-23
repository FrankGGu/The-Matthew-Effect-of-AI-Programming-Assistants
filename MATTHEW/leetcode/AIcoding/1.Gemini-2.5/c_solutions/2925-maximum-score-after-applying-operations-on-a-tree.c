#include <stdlib.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

void dfs(int u, int p, int* values, int** adj, int* adjSizes, long long** dp) {
    // Initialize dp values for the current node u
    // If u is not collected, it contributes 0 to the score from itself.
    dp[u][0] = 0;
    // If u is collected, it contributes its own value to the score.
    dp[u][1] = values[u];

    // Iterate over neighbors of u
    for (int i = 0; i < adjSizes[u]; ++i) {
        int v = adj[u][i];
        if (v == p) {
            continue; // Skip the parent node to avoid going back up the tree
        }

        // Recursively call DFS for the child node v
        dfs(v, u, values, adj, adjSizes, dp);

        // Update dp[u][0]: If node u is NOT collected, its children v can either be collected or not collected.
        // We choose the maximum score achievable from each child's subtree.
        dp[u][0] += max(dp[v][0], dp[v][1]);

        // Update dp[u][1]: If node u IS collected, its children v CANNOT be collected (due to adjacency rule).
        // Therefore, we must take dp[v][0] for each child.
        dp[u][1] += dp[v][0];
    }
}

long long maximumScoreAfterOperations(int n, int* values, int valuesSize, int** edges, int edgesSize, int* edgesColSize) {
    // Allocate memory for the adjacency list and its sizes
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSizes = (int*)calloc(n, sizeof(int)); // calloc initializes to 0

    // First pass to count degrees of each node to allocate memory for adjacency lists
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        adjSizes[u]++;
        adjSizes[v]++;
    }

    // Allocate memory for each individual adjacency list
    for (int i = 0; i < n; ++i) {
        adj[i] = (int*)malloc(adjSizes[i] * sizeof(int));
        adjSizes[i] = 0; // Reset sizes to use as current index for adding neighbors in the next step
    }

    // Populate the adjacency list
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSizes[u]++] = v;
        adj[v][adjSizes[v]++] = u;
    }

    // Allocate memory for the DP table
    // dp[node_idx][state], where state 0 means not collected, state 1 means collected
    long long** dp = (long long**)malloc(n * sizeof(long long*));
    for (int i = 0; i < n; ++i) {
        dp[i] = (long long*)malloc(2 * sizeof(long long));
    }

    // Start DFS from node 0 (arbitrary root for a tree), with -1 as a dummy parent
    dfs(0, -1, values, adj, adjSizes, dp);

    // The maximum score for the entire tree is the maximum of collecting or not collecting the root node (node 0)
    long long result = max(dp[0][0], dp[0][1]);

    // Free all dynamically allocated memory
    for (int i = 0; i < n; ++i) {
        free(adj[i]);
        free(dp[i]);
    }
    free(adj);
    free(adjSizes);
    free(dp);

    return result;
}