var largestIsland = function(grid) {
    const n = grid.length;
    let id = 2;
    const area = new Map();

    const dfs = (i, j) => {
        if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] !== 1) return 0;
        grid[i][j] = id;
        let size = 1;
        size += dfs(i + 1, j);
        size += dfs(i - 1, j);
        size += dfs(i, j + 1);
        size += dfs(i, j - 1);
        return size;
    };

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                area.set(id, dfs(i, j));
                id++;
            }
        }
    }

    let max = area.size > 0 ? Math.max(...area.values()) : 0;

    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                const seen = new Set();
                let tempArea = 1;
                for (const [dx, dy] of directions) {
                    const ni = i + dx;
                    const nj = j + dy;
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n && grid[ni][nj] > 1) {
                        if (!seen.has(grid[ni][nj])) {
                            tempArea += area.get(grid[ni][nj]);
                            seen.add(grid[ni][nj]);
                        }
                    }
                }
                max = Math.max(max, tempArea);
            }
        }
    }

    return max;
};