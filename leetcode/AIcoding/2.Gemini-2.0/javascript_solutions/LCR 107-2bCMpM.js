var updateMatrix = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const dist = Array(m).fill(null).map(() => Array(n).fill(Infinity));
    const queue = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 0) {
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

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                if (dist[newRow][newCol] > dist[row][col] + 1) {
                    dist[newRow][newCol] = dist[row][col] + 1;
                    queue.push([newRow, newCol]);
                }
            }
        }
    }

    return dist;
};