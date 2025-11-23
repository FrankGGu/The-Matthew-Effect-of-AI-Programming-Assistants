var maxAreaOfIsland = function(grid) {
    let maxArea = 0;
    const rows = grid.length;
    const cols = grid[0].length;

    function dfs(row, col) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] === 0) {
            return 0;
        }

        grid[row][col] = 0; // Mark as visited
        let area = 1;

        area += dfs(row + 1, col);
        area += dfs(row - 1, col);
        area += dfs(row, col + 1);
        area += dfs(row, col - 1);

        return area;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                maxArea = Math.max(maxArea, dfs(i, j));
            }
        }
    }

    return maxArea;
};