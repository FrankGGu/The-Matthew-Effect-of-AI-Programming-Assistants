var swimInWater = function(grid) {
    const n = grid.length;
    const visited = new Array(n).fill(0).map(() => new Array(n).fill(false));
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const dfs = (i, j, time) => {
        if (i < 0 || i >= n || j < 0 || j >= n || visited[i][j] || grid[i][j] > time) return false;
        visited[i][j] = true;
        if (i === n - 1 && j === n - 1) return true;
        for (const [dx, dy] of directions) {
            if (dfs(i + dx, j + dy, time)) return true;
        }
        return false;
    };

    let left = grid[0][0];
    let right = 250;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        visited.fill(0).map(() => visited.push(new Array(n).fill(false)));
        if (dfs(0, 0, mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};