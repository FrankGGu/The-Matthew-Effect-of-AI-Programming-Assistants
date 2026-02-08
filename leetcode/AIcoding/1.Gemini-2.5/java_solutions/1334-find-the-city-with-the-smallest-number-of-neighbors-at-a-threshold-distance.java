import java.util.Arrays;

class Solution {
    public int findTheCity(int n, int[][] edges, int threshold) {
        long[][] dist = new long[n][n];
        long INF = (long) 1e9 + 7; // A sufficiently large number for infinity

        // Initialize distance matrix
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], INF);
            dist[i][i] = 0; // Distance to self is 0
        }

        // Populate direct edges
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            dist[u][v] = w;
            dist[v][u] = w; // Undirected graph
        }

        // Floyd-Warshall algorithm
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    // Check to prevent overflow if dist[i][k] or dist[k][j] is INF
                    if (dist[i][k] != INF && dist[k][j] != INF) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        int minReachableCities = n + 1; // Max possible is n, so n+1 is a safe initial value
        int resultCity = -1;

        // Count reachable cities for each city
        for (int i = 0; i < n; i++) {
            int currentReachableCities = 0;
            for (int j = 0; j < n; j++) {
                if (i == j) continue; // Don't count self
                if (dist[i][j] <= threshold) {
                    currentReachableCities++;
                }
            }

            // Update result based on minimum count and largest index
            // If currentReachableCities is smaller, update.
            // If currentReachableCities is equal, update to the current city 'i' because we want the largest index.
            // Since 'i' iterates from 0 to n-1, this logic correctly picks the largest index in case of a tie.
            if (currentReachableCities <= minReachableCities) {
                minReachableCities = currentReachableCities;
                resultCity = i;
            }
        }

        return resultCity;
    }
}