var maxFish = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let maxFishCollected = 0;

    function dfs(r, c) {
        // Base cases: out of bounds, or no fish (already visited or initially 0)
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === 0) {
            return 0;
        }

        let currentFish = grid[r][c];
        grid[r][c] = 0; // Mark as visited by setting to 0

        // Explore neighbors
        currentFish += dfs(r + 1, c); // Down
        currentFish += dfs(r - 1, c); // Up
        currentFish += dfs(r, c + 1); // Right
        currentFish += dfs(r, c - 1); // Left

        return currentFish;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] > 0) { // Found unvisited fish
                maxFishCollected = Math.max(maxFishCollected, dfs(i, j));
            }
        }
    }

    return maxFishCollected;
};