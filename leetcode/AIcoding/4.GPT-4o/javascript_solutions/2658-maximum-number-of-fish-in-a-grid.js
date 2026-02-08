var numFishInGrid = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let maxFish = 0;

    const dfs = (r, c) => {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === 0) return 0;
        const fishCount = grid[r][c];
        grid[r][c] = 0; // mark as visited
        return fishCount + dfs(r + 1, c) + dfs(r - 1, c) + dfs(r, c + 1) + dfs(r, c - 1);
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] > 0) {
                maxFish = Math.max(maxFish, dfs(i, j));
            }
        }
    }

    return maxFish;
};