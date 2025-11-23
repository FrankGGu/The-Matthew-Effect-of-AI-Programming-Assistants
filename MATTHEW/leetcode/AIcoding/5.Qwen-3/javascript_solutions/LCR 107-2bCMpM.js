function updateMatrix(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const queue = [];
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 0) {
                queue.push([i, j]);
            } else {
                mat[i][j] = Number.MAX_VALUE;
            }
        }
    }

    while (queue.length > 0) {
        const [i, j] = queue.shift();
        for (const [dx, dy] of directions) {
            const x = i + dx;
            const y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n && mat[x][y] === Number.MAX_VALUE) {
                mat[x][y] = mat[i][j] + 1;
                queue.push([x, y]);
            }
        }
    }

    return mat;
}