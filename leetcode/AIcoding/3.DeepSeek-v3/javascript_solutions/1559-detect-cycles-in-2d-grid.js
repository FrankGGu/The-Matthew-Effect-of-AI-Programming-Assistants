var containsCycle = function(grid) {
    const rows = grid.length;
    if (rows === 0) return false;
    const cols = grid[0].length;
    const visited = new Array(rows).fill().map(() => new Array(cols).fill(false));

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (!visited[i][j]) {
                if (dfs(grid, i, j, -1, -1, grid[i][j], visited)) {
                    return true;
                }
            }
        }
    }
    return false;
};

function dfs(grid, i, j, pi, pj, target, visited) {
    if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] !== target) {
        return false;
    }
    if (visited[i][j]) return true;

    visited[i][j] = true;

    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    for (const [di, dj] of directions) {
        const ni = i + di;
        const nj = j + dj;
        if (ni === pi && nj === pj) continue;
        if (dfs(grid, ni, nj, i, j, target, visited)) {
            return true;
        }
    }
    return false;
}