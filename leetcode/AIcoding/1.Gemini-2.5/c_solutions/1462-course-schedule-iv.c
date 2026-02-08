#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

bool* checkIfPrerequisite(int n, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // dp[i][j] will be true if course i is a prerequisite of course j
    // (i.e., there's a path from i to j in the directed graph).
    bool** dp = (bool**)malloc(n * sizeof(bool*));
    for (int i = 0; i < n; i++) {
        dp[i] = (bool*)malloc(n * sizeof(bool));
        memset(dp[i], 0, n * sizeof(bool)); // Initialize all to false
    }

    // Populate direct prerequisites
    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][0];
        int v = prerequisites[i][1];
        dp[u][v] = true;
    }

    // Floyd-Warshall algorithm to find all-pairs reachability
    // k is the intermediate node
    for (int k = 0; k < n; k++) {
        // i is the starting node
        for (int i = 0; i < n; i++) {
            // j is the ending node
            for (int j = 0; j < n; j++) {
                // If there's a path from i to k AND a path from k to j,
                // then there's a path from i to j.
                dp[i][j] = dp[i][j] || (dp[i][k] && dp[k][j]);
            }
        }
    }

    // Process queries
    *returnSize = queriesSize;
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        result[i] = dp[u][v];
    }

    // Free allocated memory for the dp matrix
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}