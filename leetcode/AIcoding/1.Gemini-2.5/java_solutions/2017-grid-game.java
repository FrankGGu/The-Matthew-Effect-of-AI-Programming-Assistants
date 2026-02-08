class Solution {
    public long gridGame(int[][] grid) {
        int n = grid[0].length;

        long[] topSuffixSum = new long[n];
        topSuffixSum[n - 1] = grid[0][n - 1];
        for (int i = n - 2; i >= 0; i--) {
            topSuffixSum[i] = topSuffixSum[i + 1] + grid[0][i];
        }

        long[] bottomPrefixSum = new long[n];
        bottomPrefixSum[0] = grid[1][0];
        for (int i = 1; i < n; i++) {
            bottomPrefixSum[i] = bottomPrefixSum[i - 1] + grid[1][i];
        }

        long minPlayer2Score = Long.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            long topRemaining = 0;
            if (i < n - 1) {
                topRemaining = topSuffixSum[i + 1];
            }

            long bottomRemaining = 0;
            if (i > 0) {
                bottomRemaining = bottomPrefixSum[i - 1];
            }

            long currentPlayer2Score = Math.max(topRemaining, bottomRemaining);
            minPlayer2Score = Math.min(minPlayer2Score, currentPlayer2Score);
        }

        return minPlayer2Score;
    }
}