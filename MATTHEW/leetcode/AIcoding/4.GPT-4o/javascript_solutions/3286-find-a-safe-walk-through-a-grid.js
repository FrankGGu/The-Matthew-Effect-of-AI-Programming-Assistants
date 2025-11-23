function isSafe(grid, x, y, visited) {
    return (
        x >= 0 && x < grid.length &&
        y >= 0 && y < grid[0].length &&
        grid[x][y] === 0 &&
        !visited[x][y]
    );
}

function dfs(grid, x, y, visited) {
    if (x === grid.length - 1 && y === grid[0].length - 1) {
        return true;
    }
    visited[x][y] = true;
    const directions = [[1, 0], [0, 1], [-1, 0], [0, -1]];
    for (const [dx, dy] of directions) {
        const nx = x + dx;
        const ny = y + dy;
        if (isSafe(grid, nx, ny, visited) && dfs(grid, nx, ny, visited)) {
            return true;
        }
    }
    visited[x][y] = false;
    return false;
}

function isPathAvailable(grid) {
    const visited = Array.from({ length: grid.length }, () => Array(grid[0].length).fill(false));
    return dfs(grid, 0, 0, visited);
}