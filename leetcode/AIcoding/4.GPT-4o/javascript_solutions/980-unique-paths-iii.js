var uniquePathsIII = function(grid) {
    let startX, startY, endX, endY, emptyCount = 0;

    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] === 1) {
                startX = i;
                startY = j;
            }
            if (grid[i][j] === 2) {
                endX = i;
                endY = j;
            }
            if (grid[i][j] === 0) {
                emptyCount++;
            }
        }
    }

    let dfs = (x, y, remaining) => {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] === -1) {
            return 0;
        }
        if (x === endX && y === endY) {
            return remaining === 0 ? 1 : 0;
        }

        grid[x][y] = -1;
        let paths = dfs(x + 1, y, remaining - 1) + 
                    dfs(x - 1, y, remaining - 1) + 
                    dfs(x, y + 1, remaining - 1) + 
                    dfs(x, y - 1, remaining - 1);
        grid[x][y] = 0;

        return paths;
    };

    return dfs(startX, startY, emptyCount + 1);
};