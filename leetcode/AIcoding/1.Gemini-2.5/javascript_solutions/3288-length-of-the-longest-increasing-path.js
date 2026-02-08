var longestIncreasingPath = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const rows = matrix.length;
    const cols = matrix[0.length];
    const memo = Array(rows).fill(0).map(() => Array(cols).fill(0));
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    let maxLength = 0;

    function dfs(r, c) {
        if (memo[r][c] !== 0) {
            return memo[r][c];
        }

        let currentMax = 1; // Minimum path length is 1 (the cell itself)

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix[nr][nc] > matrix[r][c]) {
                currentMax = Math.max(currentMax, 1 + dfs(nr, nc));
            }
        }

        memo[r][c] = currentMax;
        return currentMax;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            maxLength = Math.max(maxLength, dfs(i, j));
        }
    }

    return maxLength;
};