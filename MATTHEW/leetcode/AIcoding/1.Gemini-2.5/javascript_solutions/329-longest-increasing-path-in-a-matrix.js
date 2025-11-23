var longestIncreasingPath = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const m = matrix.length;
    const n = matrix[0].length;
    const dp = Array(m).fill(0).map(() => Array(n).fill(0));
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    let overallMax = 0;

    function dfs(row, col) {
        if (dp[row][col] !== 0) {
            return dp[row][col];
        }

        let maxLen = 1;

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && matrix[newRow][newCol] > matrix[row][col]) {
                maxLen = Math.max(maxLen, 1 + dfs(newRow, newCol));
            }
        }

        dp[row][col] = maxLen;
        return maxLen;
    }

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            overallMax = Math.max(overallMax, dfs(r, c));
        }
    }

    return overallMax;
};