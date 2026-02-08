class Solution {
    public long sumScores(String s) {
        int n = s.length();
        long totalScore = 0;

        // Z-algorithm implementation
        int[] z = new int[n];
        z[0] = n; // The LCP of s with itself (s[0...]) is n.

        int L = 0, R = 0; // [L, R] is the current Z-box
        for (int i = 1; i < n; ++i) {
            // If i is within the current Z-box [L, R]
            if (i <= R) {
                // We can use previously computed Z-values to get a lower bound for z[i]
                // z[i - L] is the Z-value for the corresponding position in the prefix s[0...R-L]
                // The length of the common prefix cannot exceed R - i + 1
                z[i] = Math.min(R - i + 1, z[i - L]);
            }
            // Naive comparison to extend the common prefix
            while (i + z[i] < n && s.charAt(z[i]) == s.charAt(i + z[i])) {
                z[i]++;
            }
            // If the current Z-box extends beyond R, update L and R
            if (i + z[i] - 1 > R) {
                L = i;
                R = i + z[i] - 1;
            }
        }

        // The problem asks for the sum of scores of built strings s[0...i].
        // The score of a string t is the number of times t appears as a prefix of s.
        // For a prefix t = s[0...k], its score is the count of indices j such that s[j...] starts with t.
        // This is equivalent to counting j such that Z[j] >= |t|.
        // The total score is sum_{k=0 to n-1} (count of j such that Z[j] >= k+1).
        // This sum is mathematically equivalent to sum_{j=0 to n-1} Z[j].
        for (int i = 0; i < n; ++i) {
            totalScore += z[i];
        }

        return totalScore;
    }
}