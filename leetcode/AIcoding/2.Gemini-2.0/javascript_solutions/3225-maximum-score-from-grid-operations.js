var maxScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array(m).fill(null).map(() => Array(n).fill(-1));

    function solve(row, col) {
        if (row === m - 1 && col === n - 1) {
            return grid[row][col];
        }

        if (dp[row][col] !== -1) {
            return dp[row][col];
        }

        let maxScore = -Infinity;

        if (row + 1 < m) {
            maxScore = Math.max(maxScore, solve(row + 1, col) + grid[row][col]);
        }

        if (col + 1 < n) {
            maxScore = Math.max(maxScore, solve(row, col + 1) + grid[row][col]);
        }

        return dp[row][col] = maxScore;
    }

    return solve(0, 0);
};