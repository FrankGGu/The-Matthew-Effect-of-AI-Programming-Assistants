var largestIsland = function(grid) {
    const n = grid.length;
    let color = 2;
    const areas = new Map();
    areas.set(0, 0);

    function dfs(i, j, c) {
        if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] !== 1) {
            return 0;
        }
        grid[i][j] = c;
        return 1 + dfs(i + 1, j, c) + dfs(i - 1, j, c) + dfs(i, j + 1, c) + dfs(i, j - 1, c);
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                const area = dfs(i, j, color);
                areas.set(color, area);
                color++;
            }
        }
    }

    let maxArea = areas.get(2) || 0;
    if (color === 2 + n * n) return maxArea;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                const neighbors = new Set();
                if (i > 0) neighbors.add(grid[i - 1][j]);
                if (i < n - 1) neighbors.add(grid[i + 1][j]);
                if (j > 0) neighbors.add(grid[i][j - 1]);
                if (j < n - 1) neighbors.add(grid[i][j + 1]);

                let currentArea = 1;
                for (const neighbor of neighbors) {
                    currentArea += areas.get(neighbor) || 0;
                }
                maxArea = Math.max(maxArea, currentArea);
            }
        }
    }

    return maxArea;
};