function minDays(grid) {
    const m = grid.length;
    const n = grid[0].length;

    function countIslands() {
        let count = 0;
        const visited = Array.from({ length: m }, () => Array(n).fill(false));
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === 1 && !visited[i][j]) {
                    dfs(i, j, visited);
                    count++;
                }
            }
        }
        return count;
    }

    function dfs(i, j, visited) {
        if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] === 0 || visited[i][j]) {
            return;
        }
        visited[i][j] = true;
        dfs(i + 1, j, visited);
        dfs(i - 1, j, visited);
        dfs(i, j + 1, visited);
        dfs(i, j - 1, visited);
    }

    const initial = countIslands();
    if (initial !== 1) return 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                grid[i][j] = 0;
                if (countIslands() !== 1) {
                    return 1;
                }
                grid[i][j] = 1;
            }
        }
    }

    return 2;
}