function longestIncreasingPath(matrix) {
    if (matrix.length === 0) return 0;
    const rows = matrix.length;
    const cols = matrix[0].length;
    const dp = Array.from({ length: rows }, () => Array(cols).fill(0));
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    function dfs(r, c) {
        if (dp[r][c] !== 0) return dp[r][c];
        let maxPath = 1;
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix[nr][nc] > matrix[r][c]) {
                const path = 1 + dfs(nr, nc);
                maxPath = Math.max(maxPath, path);
            }
        }
        dp[r][c] = maxPath;
        return maxPath;
    }

    let result = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            result = Math.max(result, dfs(i, j));
        }
    }
    return result;
}