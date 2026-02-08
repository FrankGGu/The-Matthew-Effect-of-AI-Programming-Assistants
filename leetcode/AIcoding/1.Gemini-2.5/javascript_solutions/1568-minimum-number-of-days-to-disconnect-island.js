var minDays = function(grid) {
    const R = grid.length;
    const C = grid[0].length;

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    const countIslands = (currentGrid) => {
        let numComponents = 0;
        const visited = new Set();

        const dfs = (r, c) => {
            const key = `${r},${c}`;
            if (visited.has(key)) {
                return;
            }
            visited.add(key);

            for (let i = 0; i < 4; i++) {
                const nr = r + dr[i];
                const nc = c + dc[i];

                if (nr >= 0 && nr < R && nc >= 0 && nc < C && currentGrid[nr][nc] === 1) {
                    dfs(nr, nc);
                }
            }
        };

        for (let r = 0; r < R; r++) {
            for (let c = 0; c < C; c++) {
                if (currentGrid[r][c] === 1 && !visited.has(`${r},${c}`)) {
                    numComponents++;
                    dfs(r, c);
                }
            }
        }
        return numComponents;
    };

    if (countIslands(grid) !== 1) {
        return 0;
    }

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (grid[r][c] === 1) {
                grid[r][c] = 0;
                if (countIslands(grid) !== 1) {
                    return 1;
                }
                grid[r][c] = 1;
            }
        }
    }

    return 2;
};