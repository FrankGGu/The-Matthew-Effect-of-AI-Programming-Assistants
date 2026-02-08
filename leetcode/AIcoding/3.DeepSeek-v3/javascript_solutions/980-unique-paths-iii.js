var uniquePathsIII = function(grid) {
    let startX, startY, empty = 1;
    const rows = grid.length, cols = grid[0].length;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                startX = i;
                startY = j;
            } else if (grid[i][j] === 0) {
                empty++;
            }
        }
    }

    let res = 0;

    const dfs = (x, y, count) => {
        if (x < 0 || x >= rows || y < 0 || y >= cols || grid[x][y] === -1) {
            return;
        }

        if (grid[x][y] === 2) {
            if (count === empty) {
                res++;
            }
            return;
        }

        grid[x][y] = -1;
        dfs(x + 1, y, count + 1);
        dfs(x - 1, y, count + 1);
        dfs(x, y + 1, count + 1);
        dfs(x, y - 1, count + 1);
        grid[x][y] = 0;
    };

    dfs(startX, startY, 0);
    return res;
};