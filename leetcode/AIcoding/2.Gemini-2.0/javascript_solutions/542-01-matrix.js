var updateMatrix = function(matrix) {
    if (!matrix || matrix.length === 0) return matrix;

    const rows = matrix.length;
    const cols = matrix[0].length;
    const dist = Array(rows).fill(null).map(() => Array(cols).fill(Infinity));
    const queue = [];

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === 0) {
                dist[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [row, col] = queue.shift();

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
                if (dist[newRow][newCol] > dist[row][col] + 1) {
                    dist[newRow][newCol] = dist[row][col] + 1;
                    queue.push([newRow, newCol]);
                }
            }
        }
    }

    return dist;
};