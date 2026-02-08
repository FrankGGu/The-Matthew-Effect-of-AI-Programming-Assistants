import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public int maximumScore(int[] scores, int[][] edges) {
        int n = scores.length;

        // Step 1: Build adjacency list where each entry stores (neighbor_score, neighbor_id)
        // This allows sorting neighbors by score later.
        List<int[]>[] adjWithScores = new List[n];
        for (int i = 0; i < n; i++) {
            adjWithScores[i] = new ArrayList<>();
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adjWithScores[u].add(new int[]{scores[v], v});
            adjWithScores[v].add(new int[]{scores[u], u});
        }

        // Step 2: Pre-process and store the top 3 highest-scoring neighbors for each node.
        // We need up to 3 because 'a' cannot be 'c', and 'd' cannot be 'b' or 'a'.
        // In the worst case, the top 2 neighbors might be 'b' and 'a', requiring us to check the 3rd.
        int[][] topNeighbors = new int[n][3]; // Stores neighbor IDs
        int[][] topScores = new int[n][3];    // Stores neighbor scores

        for (int i = 0; i < n; i++) {
            // Initialize with -1 to indicate no neighbor or a sentinel value
            Arrays.fill(topScores[i], -1);
            Arrays.fill(topNeighbors[i], -1);

            // Sort neighbors by score in descending order
            adjWithScores[i].sort((a, b) -> b[0] - a[0]);

            // Store up to the top 3 neighbors and their scores
            for (int k = 0; k < Math.min(3, adjWithScores[i].size()); k++) {
                topScores[i][k] = adjWithScores[i].get(k)[0];
                topNeighbors[i][k] = adjWithScores[i].get(k)[1];
            }
        }

        // Step 3: Iterate through all edges (b, c) and find the best 'a' and 'd'.
        // The path is a - b - c - d.
        long maxScore = -1; // Initialize with -1, as scores are non-negative.

        for (int[] edge : edges) {
            int b = edge[0];
            int c = edge[1];

            // Iterate through the top 3 neighbors of 'b' to find 'a'
            for (int i = 0; i < 3; i++) {
                int a = topNeighbors[b][i];
                if (a == -1) { // No more neighbors for 'b' to check
                    break;
                }
                if (a == c) { // 'a' must be distinct from 'c'
                    continue;
                }

                // Iterate through the top 3 neighbors of 'c' to find 'd'
                for (int j = 0; j < 3; j++) {
                    int d = topNeighbors[c][j];
                    if (d == -1) { // No more neighbors for 'c' to check
                        break;
                    }
                    // 'd' must be distinct from 'b' and 'a'
                    if (d == b || d == a) {
                        continue;
                    }

                    // Found a valid sequence (a, b, c, d) with all distinct nodes
                    long currentScore = (long)scores[a] + scores[b] + scores[c] + scores[d];
                    maxScore = Math.max(maxScore, currentScore);
                }
            }
        }

        // The problem specifies an 'int' return type, but the maximum score can exceed Integer.MAX_VALUE (4 * 10^9).
        // We cast to int as per the method signature. If maxScore > Integer.MAX_VALUE, this will result in an overflow.
        return (int) maxScore;
    }
}