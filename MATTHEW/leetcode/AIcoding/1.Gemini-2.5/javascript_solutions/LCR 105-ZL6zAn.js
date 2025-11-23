var maxAreaOfIsland = function(grid) {
    let maxArea = 0;
    const rows = grid.length;
    if (rows === 0) {
        return 0;
    }
    const cols = grid[0].length;

    const dfs = (r, c) => {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === 0) {
            return 0;
        }

        grid[r][c] = 0;
        let currentArea = 1;

        currentArea += dfs(r + 1, c);
        currentArea += dfs(r - 1, c);
        currentArea += dfs(r, c + 1);
        currentArea += dfs(r, c - 1);

        return currentArea;
    };

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 1) {
                maxArea = Math.max(maxArea, dfs(r, c));
            }
        }
    }

    return maxArea;
};