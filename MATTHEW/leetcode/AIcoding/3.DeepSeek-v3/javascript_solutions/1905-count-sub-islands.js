var countSubIslands = function(grid1, grid2) {
    const m = grid1.length;
    const n = grid1[0].length;
    let count = 0;

    const dfs = (i, j) => {
        if (i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] === 0) {
            return true;
        }
        grid2[i][j] = 0;
        let res = true;
        if (grid1[i][j] === 0) {
            res = false;
        }
        const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [dx, dy] of dirs) {
            res = dfs(i + dx, j + dy) && res;
        }
        return res;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid2[i][j] === 1) {
                if (dfs(i, j)) {
                    count++;
                }
            }
        }
    }

    return count;
};