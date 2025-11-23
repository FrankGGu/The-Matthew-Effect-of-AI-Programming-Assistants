var longestIncreasingPath = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const m = matrix.length;
    const n = matrix[0].length;
    const memo = Array(m).fill(0).map(() => Array(n).fill(0));
    let maxPath = 0;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    function dfs(r, c) {
        if (memo[r][c] !== 0) {
            return memo[r][c];
        }

        let currentMax = 1;

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && matrix[nr][nc] > matrix[r][c]) {
                currentMax = Math.max(currentMax, 1 + dfs(nr, nc));
            }
        }

        memo[r][c] = currentMax;
        return currentMax;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            maxPath = Math.max(maxPath, dfs(i, j));
        }
    }

    return maxPath;
};