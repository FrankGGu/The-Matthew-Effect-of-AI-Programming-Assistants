var findFarmland = function(land) {
    const m = land.length;
    const n = land[0].length;
    const result = [];

    const dfs = (row, col) => {
        if (row < 0 || row >= m || col < 0 || col >= n || land[row][col] === 0) {
            return [row - 1, col - 1];
        }

        land[row][col] = 0;
        const right = dfs(row, col + 1);
        const down = dfs(row + 1, col);

        return [Math.max(right[0], down[0], row), Math.max(right[1], down[1], col)];
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (land[i][j] === 1) {
                const bottomRight = dfs(i, j);
                result.push([i, j, bottomRight[0], bottomRight[1]]);
            }
        }
    }

    return result;
};