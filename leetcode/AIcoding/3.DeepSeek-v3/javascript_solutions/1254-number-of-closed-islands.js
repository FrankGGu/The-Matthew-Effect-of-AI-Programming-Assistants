var closedIsland = function(grid) {
    if (!grid || grid.length === 0) return 0;

    const rows = grid.length;
    const cols = grid[0].length;
    let count = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 0) {
                if (dfs(grid, i, j, rows, cols)) {
                    count++;
                }
            }
        }
    }

    return count;
};

function dfs(grid, i, j, rows, cols) {
    if (i < 0 || j < 0 || i >= rows || j >= cols) {
        return false;
    }
    if (grid[i][j] === 1) {
        return true;
    }
    grid[i][j] = 1;

    const top = dfs(grid, i - 1, j, rows, cols);
    const bottom = dfs(grid, i + 1, j, rows, cols);
    const left = dfs(grid, i, j - 1, rows, cols);
    const right = dfs(grid, i, j + 1, rows, cols);

    return top && bottom && left && right;
}