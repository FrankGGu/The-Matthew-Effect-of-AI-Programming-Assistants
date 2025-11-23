function findMaxFish(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));

    function dfs(r, c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] || grid[r][c] === 0) {
            return 0;
        }
        visited[r][c] = true;
        let total = grid[r][c];
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [dr, dc] of directions) {
            total += dfs(r + dr, c + dc);
        }
        return total;
    }

    let maxFish = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (!visited[i][j] && grid[i][j] > 0) {
                maxFish = Math.max(maxFish, dfs(i, j));
            }
        }
    }
    return maxFish;
}