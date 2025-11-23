#include <stdlib.h>
#include <limits.h> // For INT_MAX
#include <string.h> // For memcpy

long long min(long long a, long long b) {
    return a < b ? a : b;
}

int findCheapestPrice(int n, int** flights, int flightsSize, int* flightsColSize, int src, int dst, int k) {
    // Use a sufficiently large value for infinity.
    // Max possible cost is n * max_price = 100 * 10000 = 1,000,000.
    // Using LLONG_MAX / 2 to prevent overflow when adding price.
    long long INF = LLONG_MAX / 2;

    // dist[i] stores the minimum cost to reach city i using at most 's' stops
    long long* dist = (long long*)malloc(n * sizeof(long long));
    // temp_dist[i] stores the minimum cost to reach city i using at most 's+1' stops
    long long* temp_dist = (long long*)malloc(n * sizeof(long long));

    // Initialize distances
    for (int i = 0; i < n; ++i) {
        dist[i] = INF;
    }
    dist[src] = 0;

    // Bellman-Ford like iteration for k+1 times.
    // Each iteration 's' calculates the shortest paths using at most 's' intermediate stops (s+1 edges).
    for (int s = 0; s <= k; ++s) {
        // Initialize temp_dist with current dist values.
        // This is crucial because a path with fewer stops might still be cheaper
        // than a path with more stops.
        memcpy(temp_dist, dist, n * sizeof(long long));

        // Iterate through all flights to find potential cheaper paths
        for (int i = 0; i < flightsSize; ++i) {
            int u = flights[i][0];
            int v = flights[i][1];
            int price = flights[i][2];

            // If city 'u' is reachable with current 'dist[u]' (at most 's' intermediate stops)
            if (dist[u] != INF) {
                // Try to update the cost to reach 'v' using one more stop (s+1 intermediate stops)
                // Compare with existing temp_dist[v] (which includes paths with fewer stops)
                temp_dist[v] = min(temp_dist[v], dist[u] + price);
            }
        }
        // After processing all flights for this 's' iteration, update 'dist' for the next iteration.
        // 'dist' now holds the minimum costs considering up to 's+1' intermediate stops.
        memcpy(dist, temp_dist, n * sizeof(long long));
    }

    long long result = dist[dst];

    free(dist);
    free(temp_dist);

    if (result == INF) {
        return -1; // Destination is not reachable within K stops
    } else {
        return (int)result;
    }
}