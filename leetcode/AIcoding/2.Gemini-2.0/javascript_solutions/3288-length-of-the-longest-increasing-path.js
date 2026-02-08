var longestIncreasingPath = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const rows = matrix.length;
    const cols = matrix[0].length;
    const dp = Array(rows).fill(null).map(() => Array(cols).fill(0));
    let maxLen = 0;

    const dfs = (row, col, prevVal) => {
        if (row < 0 || row >= rows || col < 0 || col >= cols || matrix[row][col] <= prevVal) {
            return 0;
        }

        if (dp[row][col] !== 0) {
            return dp[row][col];
        }

        const len1 = dfs(row + 1, col, matrix[row][col]);
        const len2 = dfs(row - 1, col, matrix[row][col]);
        const len3 = dfs(row, col + 1, matrix[row][col]);
        const len4 = dfs(row, col - 1, matrix[row][col]);

        dp[row][col] = Math.max(len1, len2, len3, len4) + 1;
        return dp[row][col];
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            maxLen = Math.max(maxLen, dfs(i, j, -1));
        }
    }

    return maxLen;
};