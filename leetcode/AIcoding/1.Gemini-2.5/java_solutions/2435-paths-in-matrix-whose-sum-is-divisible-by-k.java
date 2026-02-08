class Solution {
    public int numberOfPaths(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int MOD = 1_000_000_007;

        // dp[r][c][rem] stores the number of paths from (0,0) to (r,c)
        // such that the sum of elements along the path modulo k is 'rem'.
        int[][][] dp = new int[m][n][k];

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int currentVal = grid[r][c];

                if (r == 0 && c == 0) {
                    // Base case: For the starting cell (0,0), there's one path to itself
                    // with sum modulo k equal to grid[0][0] % k.
                    dp[0][0][currentVal % k] = 1;
                    continue; 
                }

                // Iterate through all possible previous remainders
                for (int prevRem = 0; prevRem < k; prevRem++) {
                    // Calculate the new remainder if currentVal is added to prevRem
                    int newRem = (prevRem + currentVal) % k;

                    // Paths coming from the cell directly above (r-1, c)
                    if (r > 0) {
                        dp[r][c][newRem] = (dp[r][c][newRem] + dp[r - 1][c][prevRem]) % MOD;
                    }

                    // Paths coming from the cell directly to the left (r, c-1)
                    if (c > 0) {
                        dp[r][c][newRem] = (dp[r][c][newRem] + dp[r][c - 1][prevRem]) % MOD;
                    }
                }
            }
        }

        // The final answer is the number of paths to (m-1, n-1)
        // whose sum modulo k is 0.
        return dp[m - 1][n - 1][0];
    }
}