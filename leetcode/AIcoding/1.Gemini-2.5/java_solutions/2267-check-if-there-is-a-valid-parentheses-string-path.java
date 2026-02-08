class Solution {
    public boolean hasValidPath(char[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // Pre-checks for impossible scenarios
        // 1. Starting cell must be '('. If not, balance cannot start positive.
        if (grid[0][0] == ')') {
            return false;
        }
        // 2. Ending cell must be ')'. If not, balance cannot end at 0.
        if (grid[m - 1][n - 1] == '(') {
            return false;
        }
        // 3. Total path length (m-1 + n-1 + 1 = m+n-1) must be even for balance to be 0.
        // If the total length is odd, it's impossible to have an equal number of '(' and ')'.
        if ((m + n - 1) % 2 != 0) {
            return false;
        }

        // dp[r][c][balance] stores whether it's possible to reach (r, c) with 'balance'.
        // The maximum possible balance is m+n-1 (if all cells are '(').
        // So, the balance array needs to go up to m+n-1, thus size m+n.
        boolean[][][] dp = new boolean[m][n][m + n];

        // Base case: starting at (0,0) with an initial balance of 1
        // (since grid[0][0] must be '(' as per pre-check and problem logic).
        dp[0][0][1] = true;

        // Iterate through the grid cells
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                // Iterate through all possible balance values for the current cell (r,c)
                // The balance can range from 0 up to m+n-1.
                for (int bal = 0; bal < m + n; bal++) {
                    // If we cannot reach (r,c) with this 'bal', then we cannot propagate from it.
                    if (!dp[r][c][bal]) {
                        continue;
                    }

                    int newBal;

                    // Try moving right to (r, c+1)
                    if (c + 1 < n) {
                        char nextChar = grid[r][c + 1];
                        if (nextChar == '(') {
                            newBal = bal + 1;
                        } else { // nextChar == ')'
                            newBal = bal - 1;
                        }
                        // Check if the new balance is valid (non-negative and within array bounds)
                        if (newBal >= 0 && newBal < m + n) {
                            dp[r][c + 1][newBal] = true;
                        }
                    }

                    // Try moving down to (r+1, c)
                    if (r + 1 < m) {
                        char nextChar = grid[r + 1][c];
                        if (nextChar == '(') {
                            newBal = bal + 1;
                        } else { // nextChar == ')'
                            newBal = bal - 1;
                        }
                        // Check if the new balance is valid (non-negative and within array bounds)
                        if (newBal >= 0 && newBal < m + n) {
                            dp[r + 1][c][newBal] = true;
                        }
                    }
                }
            }
        }

        // The final answer is whether we can reach the bottom-right cell (m-1, n-1)
        // with a balance of 0 (indicating a valid parentheses string).
        return dp[m - 1][n - 1][0];
    }
}