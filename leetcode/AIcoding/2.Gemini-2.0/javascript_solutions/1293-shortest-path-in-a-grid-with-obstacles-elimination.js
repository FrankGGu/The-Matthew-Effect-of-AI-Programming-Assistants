var shortestPath = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    if (m === 1 && n === 1) return 0;
    const visited = Array(m).fill(null).map(() => Array(n).fill(null).map(() => Array(k + 1).fill(false)));
    const queue = [[0, 0, k, 0]]; // row, col, remaining eliminations, distance
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [row, col, eliminations, distance] = queue.shift();

        if (row === m - 1 && col === n - 1) {
            return distance;
        }

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                if (grid[newRow][newCol] === 0) {
                    if (!visited[newRow][newCol][eliminations]) {
                        visited[newRow][newCol][eliminations] = true;
                        queue.push([newRow, newCol, eliminations, distance + 1]);
                    }
                } else {
                    if (eliminations > 0 && !visited[newRow][newCol][eliminations - 1]) {
                        visited[newRow][newCol][eliminations - 1] = true;
                        queue.push([newRow, newCol, eliminations - 1, distance + 1]);
                    }
                }
            }
        }
    }

    return -1;
};