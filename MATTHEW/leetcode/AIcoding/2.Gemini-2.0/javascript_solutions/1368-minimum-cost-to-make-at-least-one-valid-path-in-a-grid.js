var minCost = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dist = Array(m).fill(null).map(() => Array(n).fill(Infinity));
    dist[0][0] = 0;
    const queue = [[0, 0]];
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [row, col] = queue.shift();

        for (let i = 0; i < 4; i++) {
            const newRow = row + directions[i][0];
            const newCol = col + directions[i][1];

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                const cost = (grid[row][col] === i + 1) ? 0 : 1;
                if (dist[row][col] + cost < dist[newRow][newCol]) {
                    dist[newRow][newCol] = dist[row][col] + cost;
                    queue.push([newRow, newCol]);
                }
            }
        }
    }

    return dist[m - 1][n - 1];
};