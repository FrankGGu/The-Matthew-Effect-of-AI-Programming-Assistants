var shortestPathBinaryMatrix = function(grid) {
    const n = grid.length;
    if (grid[0][0] === 1 || grid[n - 1][n - 1] === 1) {
        return -1;
    }

    const queue = [[0, 0, 1]];
    grid[0][0] = 1;

    const directions = [
        [0, 1], [0, -1], [1, 0], [-1, 0],
        [1, 1], [1, -1], [-1, 1], [-1, -1]
    ];

    while (queue.length > 0) {
        const [row, col, dist] = queue.shift();

        if (row === n - 1 && col === n - 1) {
            return dist;
        }

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n && grid[newRow][newCol] === 0) {
                grid[newRow][newCol] = 1;
                queue.push([newRow, newCol, dist + 1]);
            }
        }
    }

    return -1;
};