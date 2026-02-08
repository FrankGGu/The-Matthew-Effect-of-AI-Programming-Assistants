var maxDistance = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const queue = [];
    const visited = Array(rows).fill(null).map(() => Array(cols).fill(false));

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                queue.push([i, j, 0]);
                visited[i][j] = true;
            }
        }
    }

    if (queue.length === 0 || queue.length === rows * cols) {
        return -1;
    }

    let maxDist = -1;
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [row, col, dist] = queue.shift();
        maxDist = Math.max(maxDist, dist);

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && !visited[newRow][newCol]) {
                queue.push([newRow, newCol, dist + 1]);
                visited[newRow][newCol] = true;
            }
        }
    }

    return maxDist;
};