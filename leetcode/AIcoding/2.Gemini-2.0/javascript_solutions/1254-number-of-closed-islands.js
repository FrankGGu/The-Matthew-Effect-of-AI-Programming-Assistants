var closedIsland = function(grid) {
    let rows = grid.length;
    let cols = grid[0].length;
    let count = 0;

    function dfs(row, col) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] === 1) {
            return;
        }

        grid[row][col] = 1;
        dfs(row + 1, col);
        dfs(row - 1, col);
        dfs(row, col + 1);
        dfs(row, col - 1);
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if ((i === 0 || i === rows - 1 || j === 0 || j === cols - 1) && grid[i][j] === 0) {
                dfs(i, j);
            }
        }
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 0) {
                count++;
                dfs(i, j);
            }
        }
    }

    return count;
};