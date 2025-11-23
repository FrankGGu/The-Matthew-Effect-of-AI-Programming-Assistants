#include <limits.h> // Required for INT_MAX, though a custom large number is used for INF
#include <stdlib.h> // For general utilities, not strictly needed for this specific VLA approach

#define INF 1000000000

int findTheCity(int n, int** edges, int edgesSize, int* edgesColSize, int distanceThreshold) {
    // dist[i][j] will store the shortest distance from city i to city j
    // Using a Variable Length Array (VLA) which is a C99 feature.
    int dist[n][n];

    // Initialize the distance matrix
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i == j) {
                dist[i][j] = 0; // Distance from a city to itself is 0
            } else {
                dist[i][j] = INF; // Initialize all other distances to infinity
            }
        }
    }

    // Populate the distance matrix with direct edge weights
    for (int k = 0; k < edgesSize; k++) {
        int u = edges[k][0];
        int v = edges[k][1];
        int weight = edges[k][2];
        dist[u][v] = weight;
        dist[v][u] = weight; // Edges are bidirectional
    }

    // Floyd-Warshall Algorithm to compute all-pairs shortest paths
    // k is the intermediate city
    for (int k = 0; k < n; k++) {
        // i is the source city
        for (int i = 0; i < n; i++) {
            // j is the destination city
            for (int j = 0; j < n; j++) {
                // Check if paths through k are valid (not INF) to prevent overflow
                if (dist[i][k] != INF && dist[k][j] != INF) {
                    if (dist[i][j] > dist[i][k] + dist[k][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }
    }

    int minReachableCities = n + 1; // Initialize with a value greater than any possible count (n)
    int resultCity = -1; // Initialize with an invalid city index

    // Iterate through each city to find the one with the smallest number of reachable cities
    for (int i = 0; i < n; i++) {
        int reachableCount = 0;
        for (int j = 0; j < n; j++) {
            if (i == j) continue; // Do not count the city itself
            if (dist[i][j] <= distanceThreshold) {
                reachableCount++;
            }
        }

        // Update the result based on the count of reachable cities
        // If current city has fewer reachable cities, update
        // If counts are equal, choose the city with the larger index (achieved by <= and iterating i upwards)
        if (reachableCount <= minReachableCities) {
            minReachableCities = reachableCount;
            resultCity = i;
        }
    }

    return resultCity;
}