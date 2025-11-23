import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public String findShortestSuperstring(String[] words) {
        int n = words.length;

        // Precompute overlap between all pairs of words
        // overlap[i][j] = length of suffix of words[i] that is also a prefix of words[j]
        int[][] overlap = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                overlap[i][j] = calculateOverlap(words[i], words[j]);
            }
        }

        // dp[mask][i] = minimum length of a superstring using words in 'mask', ending with words[i]
        int[][] dp = new int[1 << n][n];
        // parent[mask][i] = the previous word index in the optimal path leading to dp[mask][i]
        int[][] parent = new int[1 << n][n];

        // Initialize dp table with a large value
        for (int i = 0; i < (1 << n); i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2); // Use /2 to prevent overflow during addition
        }

        // Base cases: A superstring with only one word
        for (int i = 0; i < n; i++) {
            dp[1 << i][i] = words[i].length();
        }

        // Fill dp table
        for (int mask = 1; mask < (1 << n); mask++) {
            for (int j = 0; j < n; j++) { // Current word (last word in the superstring)
                if ((mask & (1 << j)) == 0) continue; // If words[j] is not in the current mask

                int prevMask = mask ^ (1 << j); // Mask without words[j]

                if (prevMask == 0) continue; // If prevMask is empty, it's a base case already handled

                for (int i = 0; i < n; i++) { // Previous word
                    if ((prevMask & (1 << i)) != 0) { // If words[i] is in prevMask
                        // Calculate length if words[j] is appended after words[i]
                        int currentLength = dp[prevMask][i] + words[j].length() - overlap[i][j];

                        if (currentLength < dp[mask][j]) {
                            dp[mask][j] = currentLength;
                            parent[mask][j] = i; // Store previous word index
                        }
                    }
                }
            }
        }

        // Find the minimum length superstring and its ending word
        int minLength = Integer.MAX_VALUE;
        int lastWordIndex = -1;
        int finalMask = (1 << n) - 1;

        for (int i = 0; i < n; i++) {
            if (dp[finalMask][i] < minLength) {
                minLength = dp[finalMask][i];
                lastWordIndex = i;
            }
        }

        // Reconstruct the path (order of words)
        List<Integer> path = new ArrayList<>();
        int currentMask = finalMask;

        while (currentMask > 0) {
            path.add(lastWordIndex);
            int prevWordIndex = parent[currentMask][lastWordIndex];
            currentMask ^= (1 << lastWordIndex); // Remove lastWordIndex from mask
            lastWordIndex = prevWordIndex; // Move to the previous word
        }
        Collections.reverse(path); // Path is built in reverse, so reverse it

        // Build the final superstring from the path
        StringBuilder result = new StringBuilder();
        result.append(words[path.get(0)]); // Append the first word fully
        for (int k = 1; k < n; k++) {
            int prev = path.get(k - 1);
            int curr = path.get(k);
            // Append only the non-overlapping part of the current word
            result.append(words[curr].substring(overlap[prev][curr]));
        }

        return result.toString();
    }

    // Helper function to calculate the maximum overlap
    // Returns the length of the longest suffix of s1 that is also a prefix of s2
    private int calculateOverlap(String s1, String s2) {
        int maxOverlap = 0;
        int minLength = Math.min(s1.length(), s2.length());
        for (int k = 1; k <= minLength; k++) {
            // Check if the suffix of s1 of length k is equal to the prefix of s2 of length k
            if (s1.endsWith(s2.substring(0, k))) {
                maxOverlap = k;
            }
        }
        return maxOverlap;
    }
}