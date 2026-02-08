var largestIsland = function(grid) {
    const n = grid.length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let color = 2;
    const colorToSize = {};

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                let size = 0;
                const queue = [[i, j]];
                grid[i][j] = color;

                while (queue.length > 0) {
                    const [x, y] = queue.shift();
                    size++;

                    for (const [dx, dy] of dirs) {
                        const nx = x + dx;
                        const ny = y + dy;

                        if (nx >= 0 && nx < n && ny >= 0 && ny < n && grid[nx][ny] === 1) {
                            grid[nx][ny] = color;
                            queue.push([nx, ny]);
                        }
                    }
                }

                colorToSize[color] = size;
                color++;
            }
        }
    }

    let max = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                const colors = new Set();
                let current = 1;

                for (const [dx, dy] of dirs) {
                    const ni = i + dx;
                    const nj = j + dy;

                    if (ni >= 0 && ni < n && nj >= 0 && nj < n && grid[ni][nj] !== 0) {
                        const c = grid[ni][nj];
                        if (!colors.has(c)) {
                            colors.add(c);
                            current += colorToSize[c];
                        }
                    }
                }

                max = Math.max(max, current);
            }
        }
    }

    return max === 0 ? n * n : max;
};