class Solution {
    maxScore(grid) {
        const m = grid.length, n = grid[0].length;
        const dp = Array(n).fill(0);

        for (let i = 0; i < m; i++) {
            const newDp = Array(n).fill(0);
            for (let j = 0; j < n; j++) {
                if (j > 0) {
                    newDp[j] = Math.max(newDp[j], newDp[j - 1]);
                }
                newDp[j] = Math.max(newDp[j], dp[j] + grid[i][j]);
            }
            for (let j = n - 2; j >= 0; j--) {
                newDp[j] = Math.max(newDp[j], newDp[j + 1]);
            }
            dp = newDp;
        }

        return dp[0];
    }
}