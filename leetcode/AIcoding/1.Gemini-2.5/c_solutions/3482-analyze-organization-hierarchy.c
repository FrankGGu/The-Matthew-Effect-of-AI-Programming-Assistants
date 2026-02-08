#include <stdlib.h> // For malloc, calloc, free

static int dfs_helper(int u, int n, int** adj, int* adj_list_sizes, int* memo) {
    // If the count for employee u has already been computed, return it from memo.
    if (memo[u] != -1) {
        return memo[u];
    }

    int count = 0;
    // Iterate through all direct subordinates of employee u.
    for (int i = 0; i < adj_list_sizes[u]; ++i) {
        int v = adj[u][i];
        // For each direct subordinate 'v', add 1 (for 'v' itself) plus 'v's total subordinates.
        count += (1 + dfs_helper(v, n, adj, adj_list_sizes, memo));
    }

    // Store the computed count in the memoization array and return it.
    memo[u] = count;
    return count;
}

int** getHierarchy(int n, int** manager, int managerColSize, int* managerRowSize, int* returnSize, int** returnColumnSizes) {
    // Handle the edge case where there are no employees.
    if (n == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Step 1: Build an adjacency list representing the direct subordinate relationships.
    // `adj_list_sizes[i]` will temporarily store the count of direct reports for employee `i`.
    int* adj_list_sizes = (int*)calloc(n, sizeof(int));

    // Iterate through each employee to count their direct reports.
    for (int i = 0; i < n; ++i) {
        // If employee i has a manager (manager[i][0] is not -1), increment their manager's direct report count.
        if (manager[i][0] != -1) {
            adj_list_sizes[manager[i][0]]++;
        }
    }

    // Allocate memory for the adjacency list.
    // `adj[i]` will be an array storing the IDs of employees directly managed by `i`.
    int** adj = (int**)malloc(n * sizeof(int*));
    // `current_adj_indices[i]` will be used to track the current insertion point
    // within `adj[i]` while populating the adjacency list.
    int* current_adj_indices = (int*)calloc(n, sizeof(int)); 

    // Allocate memory for each subordinate list in the adjacency list.
    for (int i = 0; i < n; ++i) {
        adj[i] = (int*)malloc(adj_list_sizes[i] * sizeof(int));
    }

    // Populate the adjacency list with actual subordinate IDs.
    for (int i = 0; i < n; ++i) {
        if (manager[i][0] != -1) {
            int mgr = manager[i][0];
            adj[mgr][current_adj_indices[mgr]++] = i;
        }
    }

    // Step 2: Initialize memoization array for DFS.
    // `memo[i]` will store the total subordinate count for employee `i`.
    // Initialize with -1 to indicate that counts have not yet been computed.
    int* memo = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        memo[i] = -1;
    }

    // Step 3: Prepare the result array and populate it using DFS.
    // The result will be a 2D array where each row `i` contains a single integer
    // representing the total subordinates for employee `i`.
    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; ++i) {
        result[i] = (int*)malloc(sizeof(int));
        (*returnColumnSizes)[i] = 1;
        // Call DFS for each employee to compute their total subordinates.
        // The `dfs_helper` function handles memoization to avoid redundant computations.
        result[i][0] = dfs_helper(i, n, adj, adj_list_sizes, memo);
    }

    // Step 4: Free internally allocated memory to prevent memory leaks.
    for (int i = 0; i < n; ++i) {
        free(adj[i]);
    }
    free(adj);
    free(adj_list_sizes);
    free(current_adj_indices); 
    free(memo);

    // Return the result array. LeetCode grader will free `result` and `*returnColumnSizes`.
    return result;
}