var longestIncreasingPath = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const rows = matrix.length;
    const cols = matrix[0].length;
    const dp = Array(rows).fill(null).map(() => Array(cols).fill(0));
    let maxLen = 0;

    const dfs = (row, col) => {
        if (dp[row][col] !== 0) {
            return dp[row][col];
        }

        let len = 1;
        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && matrix[newRow][newCol] > matrix[row][col]) {
                len = Math.max(len, 1 + dfs(newRow, newCol));
            }
        }

        dp[row][col] = len;
        return len;
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            maxLen = Math.max(maxLen, dfs(i, j));
        }
    }

    return maxLen;
};