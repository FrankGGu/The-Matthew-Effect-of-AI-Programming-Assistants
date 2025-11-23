var isPossibleToCutPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    function dfs(x, y) {
        if (x === m - 1 && y === n - 1) {
            return true;
        }
        if (x >= m || y >= n || grid[x][y] === 0) {
            return false;
        }
        grid[x][y] = 0;
        return dfs(x + 1, y) || dfs(x, y + 1);
    }

    if (!dfs(0, 0)) {
        return true;
    }
    grid[0][0] = 1;
    return !dfs(0, 0);
};