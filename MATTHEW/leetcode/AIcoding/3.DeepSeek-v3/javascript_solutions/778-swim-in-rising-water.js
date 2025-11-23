var swimInWater = function(grid) {
    const n = grid.length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let left = 0, right = n * n - 1;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const visited = new Array(n).fill().map(() => new Array(n).fill(false));
        if (canReach(grid, mid, 0, 0, visited, dirs)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};

function canReach(grid, t, i, j, visited, dirs) {
    const n = grid.length;
    if (i < 0 || i >= n || j < 0 || j >= n || visited[i][j] || grid[i][j] > t) {
        return false;
    }
    if (i === n - 1 && j === n - 1) {
        return true;
    }
    visited[i][j] = true;
    for (const [di, dj] of dirs) {
        if (canReach(grid, t, i + di, j + dj, visited, dirs)) {
            return true;
        }
    }
    return false;
}