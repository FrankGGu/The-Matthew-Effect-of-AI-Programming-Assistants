var longestIncreasingPath = function(matrix) {
    if (!matrix.length || !matrix[0].length) return 0;
    const m = matrix.length, n = matrix[0].length;
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const memo = new Array(m).fill(0).map(() => new Array(n).fill(0));
    let max = 0;

    const dfs = (i, j) => {
        if (memo[i][j] !== 0) return memo[i][j];
        let len = 1;
        for (const [dx, dy] of dirs) {
            const x = i + dx, y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] > matrix[i][j]) {
                len = Math.max(len, 1 + dfs(x, y));
            }
        }
        memo[i][j] = len;
        return len;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            max = Math.max(max, dfs(i, j));
        }
    }

    return max;
};