class Solution {
    public long maximumAmount(int[][] grid) {
        int n = grid[0].length;

        long[] prefixSum0 = new long[n];
        long[] suffixSum1 = new long[n];

        // Calculate prefix sums for row 0
        prefixSum0[0] = grid[0][0];
        for (int j = 1; j < n; j++) {
            prefixSum0[j] = prefixSum0[j - 1] + grid[0][j];
        }

        // Calculate suffix sums for row 1
        suffixSum1[n - 1] = grid[1][n - 1];
        for (int j = n - 2; j >= 0; j--) {
            suffixSum1[j] = suffixSum1[j + 1] + grid[1][j];
        }

        long maxEarn = 0;

        // Iterate through all possible split points 'i'
        // A split point 'i' means the robot collects from grid[0][0]...grid[0][i]
        // then moves to grid[1][i], and collects from grid[1][i]...grid[1][n-1].
        for (int i = 0; i < n; i++) {
            long currentEarn = prefixSum0[i] + suffixSum1[i];
            if (currentEarn > maxEarn) {
                maxEarn = currentEarn;
            }
        }

        return maxEarn;
    }
}