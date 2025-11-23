function canTraverseGrid(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const visited = new Array(n).fill(0).map(() => new Array(m).fill(false));
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    function dfs(x, y, prevGcd) {
        if (x < 0 || x >= n || y < 0 || y >= m || visited[x][y]) return false;
        visited[x][y] = true;

        if (x === n - 1 && y === m - 1) return true;

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny]) {
                const currentGcd = gcd(grid[x][y], grid[nx][ny]);
                if (currentGcd > 1) {
                    if (dfs(nx, ny, currentGcd)) return true;
                }
            }
        }

        return false;
    }

    return dfs(0, 0, 0);
}