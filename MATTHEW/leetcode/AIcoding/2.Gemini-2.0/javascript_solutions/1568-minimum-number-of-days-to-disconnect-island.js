var minDays = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    function countIslands(grid) {
        let count = 0;
        const visited = Array(m).fill(null).map(() => Array(n).fill(false));

        function dfs(i, j) {
            if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] === 0 || visited[i][j]) {
                return;
            }
            visited[i][j] = true;
            dfs(i + 1, j);
            dfs(i - 1, j);
            dfs(i, j + 1);
            dfs(i, j - 1);
        }

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === 1 && !visited[i][j]) {
                    count++;
                    dfs(i, j);
                }
            }
        }
        return count;
    }

    let initialIslands = countIslands(grid);

    if (initialIslands === 0 || initialIslands > 1) {
        return 0;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                const temp = grid[i][j];
                grid[i][j] = 0;
                if (countIslands(grid) !== 1) {
                    grid[i][j] = temp;
                    return 1;
                }
                grid[i][j] = temp;
            }
        }
    }

    return 2;
};