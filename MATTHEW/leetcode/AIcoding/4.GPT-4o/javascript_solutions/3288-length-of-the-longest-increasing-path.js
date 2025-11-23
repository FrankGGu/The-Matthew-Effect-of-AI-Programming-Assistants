var longestIncreasingPath = function(matrix) {
    if (matrix.length === 0) return 0;
    const rows = matrix.length, cols = matrix[0].length;
    const dp = Array.from({ length: rows }, () => Array(cols).fill(0));
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const isValid = (x, y) => x >= 0 && x < rows && y >= 0 && y < cols;

    const dfs = (x, y) => {
        if (dp[x][y] !== 0) return dp[x][y];
        let maxLength = 1;
        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;
            if (isValid(nx, ny) && matrix[nx][ny] > matrix[x][y]) {
                maxLength = Math.max(maxLength, 1 + dfs(nx, ny));
            }
        }
        dp[x][y] = maxLength;
        return maxLength;
    };

    let longestPath = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            longestPath = Math.max(longestPath, dfs(i, j));
        }
    }
    return longestPath;
};