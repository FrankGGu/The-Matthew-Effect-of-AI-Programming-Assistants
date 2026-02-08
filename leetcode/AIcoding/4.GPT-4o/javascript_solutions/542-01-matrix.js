function updateMatrix(mat) {
    const rows = mat.length;
    const cols = mat[0].length;
    const dist = Array.from({ length: rows }, () => Array(cols).fill(Infinity));
    const queue = [];

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (mat[i][j] === 0) {
                dist[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }

    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    while (queue.length) {
        const [x, y] = queue.shift();

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && dist[nx][ny] > dist[x][y] + 1) {
                dist[nx][ny] = dist[x][y] + 1;
                queue.push([nx, ny]);
            }
        }
    }

    return dist;
}