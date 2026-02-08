import java.util.Arrays;

class Solution {
    public long[] countOfPairs(int n, int x, int y) {
        // Use 1-based indexing for houses to match problem description (1 to n).
        // x and y are 1-indexed.

        // A sufficiently large value for infinity, ensuring it doesn't overflow when added.
        // Maximum possible path length is n-1, so 2 * (n-1) is max intermediate sum.
        // 100 * 100 = 10000, so 1_000_000_000 is safe.
        final int INF = 1_000_000_000; 

        // d[i][j] will store the shortest distance between house i and house j.
        // Array size n+1 to accommodate 1-based indexing from 1 to n.
        int[][] d = new int[n + 1][n + 1];

        // Initialize distances: 0 for self, INF for others.
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                if (i == j) {
                    d[i][j] = 0;
                } else {
                    d[i][j] = INF;
                }
            }
        }

        // Add direct paths (cycle connections): distance 1 between adjacent houses.
        for (int i = 1; i < n; i++) {
            d[i][i + 1] = 1;
            d[i + 1][i] = 1;
        }
        // Connection between n and 1 to complete the cycle.
        d[n][1] = 1;
        d[1][n] = 1;

        // Add the special path (shortcut) between x and y.
        d[x][y] = 1;
        d[y][x] = 1;

        // Floyd-Warshall algorithm to find all-pairs shortest paths.
        // k is the intermediate node.
        for (int k = 1; k <= n; k++) {
            // i is the source node.
            for (int i = 1; i <= n; i++) {
                // j is the destination node.
                for (int j = 1; j <= n; j++) {
                    // Check if paths d[i][k] and d[k][j] are reachable to prevent overflow
                    // and ensure we don't add to INF.
                    if (d[i][k] != INF && d[k][j] != INF) {
                        d[i][j] = Math.min(d[i][j], d[i][k] + d[k][j]);
                    }
                }
            }
        }

        // Count pairs for each distance.
        // `counts[dist]` will store the number of pairs with shortest path `dist`.
        // Array size n+1, as distances can range from 1 to n-1. `counts[0]` will be unused.
        long[] counts = new long[n + 1]; 

        // Iterate through all unique pairs (i, j) where i < j.
        for (int i = 1; i <= n; i++) {
            for (int j = i + 1; j <= n; j++) {
                int distance = d[i][j];
                // Increment the count for the found distance.
                // Valid distances are from 1 to n-1.
                if (distance >= 1 && distance <= n - 1) {
                    counts[distance]++;
                }
            }
        }

        // The problem asks for an array `ans` of size `n-1` where `ans[k]` is the number
        // of pairs with shortest path `k+1`.
        // Our `counts` array stores `counts[distance]` for shortest path `distance`.
        // So, `ans[k]` should be `counts[k+1]`.
        long[] finalResult = new long[n - 1];
        for (int k = 0; k < n - 1; k++) {
            finalResult[k] = counts[k + 1];
        }

        return finalResult;
    }
}