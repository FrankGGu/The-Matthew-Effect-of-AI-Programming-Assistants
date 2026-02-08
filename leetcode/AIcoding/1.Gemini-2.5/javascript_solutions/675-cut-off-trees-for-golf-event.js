var cutOffTree = function(forest) {
    const m = forest.length;
    const n = forest[0].length;

    const trees = [];
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (forest[r][c] > 1) {
                trees.push([forest[r][c], r, c]);
            }
        }
    }

    trees.sort((a, b) => a[0] - b[0]);

    let totalSteps = 0;
    let currentRow = 0;
    let currentCol = 0;

    const bfs = (grid, startR, startC, endR, endC) => {
        if (startR === endR && startC === endC) {
            return 0;
        }

        const rows = grid.length;
        const cols = grid[0].length;
        const queue = [[startR, startC, 0]];
        const visited = new Set();
        visited.add(`${startR},${startC}`);

        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        while (queue.length > 0) {
            const [r, c, steps] = queue.shift();

            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] > 0 && !visited.has(`${nr},${nc}`)) {
                    if (nr === endR && nc === endC) {
                        return steps + 1;
                    }
                    visited.add(`${nr},${nc}`);
                    queue.push([nr, nc, steps + 1]);
                }
            }
        }
        return -1;
    };

    for (const tree of trees) {
        const [height, targetR, targetC] = tree;
        const steps = bfs(forest, currentRow, currentCol, targetR, targetC);

        if (steps === -1) {
            return -1;
        }

        totalSteps += steps;
        currentRow = targetR;
        currentCol = targetC;
    }

    return totalSteps;
};