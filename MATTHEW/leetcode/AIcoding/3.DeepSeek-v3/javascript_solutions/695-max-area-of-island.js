var maxAreaOfIsland = function(grid) {
    let maxArea = 0;
    const rows = grid.length;
    const cols = grid[0].length;

    const dfs = (i, j) => {
        if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] !== 1) {
            return 0;
        }
        grid[i][j] = 0;
        return 1 + dfs(i + 1, j) + dfs(i - 1, j) + dfs(i, j + 1) + dfs(i, j - 1);
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                maxArea = Math.max(maxArea, dfs(i, j));
            }
        }
    }

    return maxArea;
};