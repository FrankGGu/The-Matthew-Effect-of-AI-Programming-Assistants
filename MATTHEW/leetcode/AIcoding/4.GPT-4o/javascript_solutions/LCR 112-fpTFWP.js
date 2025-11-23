var longestIncreasingPath = function(matrix) {
    if (!matrix.length) return 0;
    const rows = matrix.length, cols = matrix[0].length;
    const dp = Array.from({ length: rows }, () => Array(cols).fill(0));
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const dfs = (r, c) => {
        if (dp[r][c] !== 0) return dp[r][c];
        let maxPath = 1;
        for (const [dr, dc] of directions) {
            const newRow = r + dr, newCol = c + dc;
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && matrix[newRow][newCol] > matrix[r][c]) {
                maxPath = Math.max(maxPath, 1 + dfs(newRow, newCol));
            }
        }
        dp[r][c] = maxPath;
        return maxPath;
    };

    let longestPath = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            longestPath = Math.max(longestPath, dfs(i, j));
        }
    }
    return longestPath;
};