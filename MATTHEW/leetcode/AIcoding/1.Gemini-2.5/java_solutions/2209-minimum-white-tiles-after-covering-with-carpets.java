class Solution {
    public int minimumWhiteTiles(String floor, int numCarpets, int carpetLen) {
        int n = floor.length();

        // prefixWhite[i] stores the number of white tiles in floor[0...i-1]
        int[] prefixWhite = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixWhite[i + 1] = prefixWhite[i] + (floor.charAt(i) == '1' ? 1 : 0);
        }

        // dp[i][j] = minimum white tiles remaining in floor[0...i-1] using j carpets
        // dp table size: (n+1) x (numCarpets+1)
        int[][] dp = new int[n + 1][numCarpets + 1];

        // Initialize dp table
        // dp[i][0]: If we use 0 carpets, all white tiles in floor[0...i-1] remain.
        for (int i = 0; i <= n; i++) {
            dp[i][0] = prefixWhite[i];
        }
        // dp[0][j]: If there are no tiles (i=0), 0 white tiles remain, regardless of carpets.
        // This is implicitly handled by Java's default array initialization (all zeros)
        // and prefixWhite[0] = 0.

        // Fill dp table
        for (int i = 1; i <= n; i++) { // Iterate through floor length (up to index i-1)
            for (int j = 1; j <= numCarpets; j++) { // Iterate through number of carpets
                // Option 1: Don't place a carpet ending at floor[i-1].
                // The white tile at floor[i-1] (if any) is not covered.
                dp[i][j] = dp[i - 1][j] + (floor.charAt(i - 1) == '1' ? 1 : 0);

                // Option 2: Place a carpet ending at floor[i-1].
                // This carpet covers tiles floor[max(0, i - carpetLen) ... i-1].
                // All white tiles in this segment are covered.
                // The problem reduces to finding the minimum white tiles in floor[0...prevIndex-1]
                // using j-1 carpets, where prevIndex = max(0, i - carpetLen).
                int prevIndex = Math.max(0, i - carpetLen);
                dp[i][j] = Math.min(dp[i][j], dp[prevIndex][j - 1]);
            }
        }

        return dp[n][numCarpets];
    }
}