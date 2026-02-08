var orangesRotting = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let queue = [];
    let freshCount = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 2) {
                queue.push([i, j]);
            } else if (grid[i][j] === 1) {
                freshCount++;
            }
        }
    }

    let minutes = 0;
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0 && freshCount > 0) {
        minutes++;
        const queueLength = queue.length;
        for (let i = 0; i < queueLength; i++) {
            const [row, col] = queue.shift();
            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;
                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] === 1) {
                    grid[newRow][newCol] = 2;
                    freshCount--;
                    queue.push([newRow, newCol]);
                }
            }
        }
    }

    return freshCount === 0 ? minutes : -1;
};