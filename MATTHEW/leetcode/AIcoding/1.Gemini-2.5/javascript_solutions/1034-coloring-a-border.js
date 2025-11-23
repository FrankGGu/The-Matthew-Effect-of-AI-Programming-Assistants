var colorBorder = function(grid, row, col, color) {
    const m = grid.length;
    const n = grid[0].length;
    const originalColor = grid[row][col];
    const visited = Array(m).fill(0).map(() => Array(n).fill(false));
    const borderCells = [];

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    function dfs(r, c) {
        visited[r][c] = true;
        let componentNeighbors = 0;

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] === originalColor) {
                componentNeighbors++;
                if (!visited[nr][nc]) {
                    dfs(nr, nc);
                }
            }
        }

        if (componentNeighbors < 4) {
            borderCells.push([r, c]);
        }
    }

    dfs(row, col);

    for (const [r, c] of borderCells) {
        grid[r][c] = color;
    }

    return grid;
};