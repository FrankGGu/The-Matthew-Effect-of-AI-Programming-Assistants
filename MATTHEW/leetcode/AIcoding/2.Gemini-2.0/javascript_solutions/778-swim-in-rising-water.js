var swimInWater = function(grid) {
    const n = grid.length;
    let left = grid[0][0];
    let right = n * n - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canReach(grid, mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;

    function canReach(grid, t) {
        const n = grid.length;
        const visited = Array(n).fill(null).map(() => Array(n).fill(false));
        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        function dfs(row, col) {
            if (row < 0 || row >= n || col < 0 || col >= n || visited[row][col] || grid[row][col] > t) {
                return false;
            }
            if (row === n - 1 && col === n - 1) {
                return true;
            }
            visited[row][col] = true;
            for (const [dr, dc] of directions) {
                if (dfs(row + dr, col + dc)) {
                    return true;
                }
            }
            return false;
        }

        return dfs(0, 0);
    }
};