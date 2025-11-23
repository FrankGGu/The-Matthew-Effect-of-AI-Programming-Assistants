function getMaximumGold(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let maxGold = 0;

    function dfs(r, c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === 0) {
            return 0;
        }

        const currentGold = grid[r][c];
        grid[r][c] = 0; // mark as visited

        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        let max = 0;
        for (const [dr, dc] of directions) {
            max = Math.max(max, dfs(r + dr, c + dc));
        }

        grid[r][c] = currentGold; // backtrack
        return currentGold + max;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] > 0) {
                maxGold = Math.max(maxGold, dfs(i, j));
            }
        }
    }

    return maxGold;
}