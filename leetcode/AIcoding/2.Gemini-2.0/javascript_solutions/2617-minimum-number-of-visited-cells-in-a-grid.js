var minimumVisitedCells = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const visited = Array(m).fill(null).map(() => Array(n).fill(Infinity));
    visited[0][0] = 1;

    const rowRanges = Array(m).fill(null).map(() => []);
    const colRanges = Array(n).fill(null).map(() => []);

    rowRanges[0].push(1);
    colRanges[0].push(1);

    const queue = [[0, 0]];

    while (queue.length > 0) {
        const [row, col] = queue.shift();

        if (row === m - 1 && col === n - 1) {
            return visited[row][col];
        }

        const maxJump = grid[row][col];

        // Move right
        for (let newCol = col + 1; newCol <= Math.min(col + maxJump, n - 1); newCol++) {
            if (visited[row][newCol] === Infinity) {
                visited[row][newCol] = visited[row][col] + 1;
                queue.push([row, newCol]);
                rowRanges[row].push(newCol + 1);
            }
        }

        // Move down
        for (let newRow = row + 1; newRow <= Math.min(row + maxJump, m - 1); newRow++) {
            if (visited[newRow][col] === Infinity) {
                visited[newRow][col] = visited[row][col] + 1;
                queue.push([newRow, col]);
                colRanges[col].push(newRow + 1);
            }
        }
    }

    return -1;
};