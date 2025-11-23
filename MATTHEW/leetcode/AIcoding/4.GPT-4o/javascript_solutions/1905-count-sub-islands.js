var countSubIslands = function(grid1, grid2) {
    const m = grid1.length, n = grid1[0].length;

    const dfs = (i, j) => {
        if (i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] === 0) return;
        grid2[i][j] = 0;
        dfs(i + 1, j);
        dfs(i - 1, j);
        dfs(i, j + 1);
        dfs(i, j - 1);
    };

    let count = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid2[i][j] === 1) {
                dfs(i, j);
                let isSubIsland = true;
                for (let x = 0; x < m; x++) {
                    for (let y = 0; y < n; y++) {
                        if (grid2[x][y] === 0 && grid1[x][y] === 1) {
                            isSubIsland = false;
                            break;
                        }
                    }
                    if (!isSubIsland) break;
                }
                if (isSubIsland) count++;
            }
        }
    }

    return count;
};