function largestIsland(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let id = 2;
    const area = {};

    function dfs(r, c, id) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] !== 1) return 0;
        grid[r][c] = id;
        let count = 1;
        for (const [dr, dc] of directions) {
            count += dfs(r + dr, c + dc, id);
        }
        return count;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                const areaSize = dfs(i, j, id);
                area[id++] = areaSize;
            }
        }
    }

    let maxArea = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                const seen = new Set();
                let total = 1;
                for (const [dr, dc] of directions) {
                    const ni = i + dr;
                    const nj = j + dc;
                    if (ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] > 1) {
                        const pid = grid[ni][nj];
                        if (!seen.has(pid)) {
                            total += area[pid];
                            seen.add(pid);
                        }
                    }
                }
                maxArea = Math.max(maxArea, total);
            }
        }
    }

    if (id === 2) return m * n;
    return maxArea;
}