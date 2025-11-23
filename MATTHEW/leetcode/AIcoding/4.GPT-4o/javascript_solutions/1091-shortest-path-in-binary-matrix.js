function shortestPathBinaryMatrix(grid) {
    const n = grid.length;
    if (grid[0][0] === 1 || grid[n - 1][n - 1] === 1) return -1;

    const directions = [
        [0, 1], [1, 0], [0, -1], [-1, 0],
        [1, 1], [1, -1], [-1, 1], [-1, -1]
    ];

    const queue = [[0, 0, 1]]; // [row, col, pathLength]
    grid[0][0] = 1; // Mark as visited

    while (queue.length) {
        const [row, col, length] = queue.shift();

        if (row === n - 1 && col === n - 1) return length;

        for (const [dx, dy] of directions) {
            const newRow = row + dx;
            const newCol = col + dy;

            if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n && grid[newRow][newCol] === 0) {
                grid[newRow][newCol] = 1; // Mark as visited
                queue.push([newRow, newCol, length + 1]);
            }
        }
    }

    return -1;
}