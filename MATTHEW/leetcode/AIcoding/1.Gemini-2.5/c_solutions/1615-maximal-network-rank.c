#include <stdbool.h>
#include <string.h> // For memset

int maximalNetworkRank(int n, int** roads, int roadsSize, int* roadsColSize) {
    int degree[n];
    bool isConnected[n][n];

    // Initialize degree array to all zeros
    memset(degree, 0, sizeof(degree));

    // Initialize adjacency matrix to all false
    memset(isConnected, 0, sizeof(isConnected));

    // Populate degree and isConnected based on roads
    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];

        degree[u]++;
        degree[v]++;
        isConnected[u][v] = true;
        isConnected[v][u] = true;
    }

    int maxRank = 0;

    // Iterate through all distinct pairs of cities
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) { // j starts from i + 1 to avoid duplicate pairs and self-pairs
            int currentRank = degree[i] + degree[j];
            if (isConnected[i][j]) {
                currentRank--;
            }
            if (currentRank > maxRank) {
                maxRank = currentRank;
            }
        }
    }

    return maxRank;
}