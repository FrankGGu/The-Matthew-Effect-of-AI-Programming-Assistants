var updateMatrix = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const queue = [];
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 0) {
                queue.push([i, j]);
            } else {
                mat[i][j] = Infinity;
            }
        }
    }

    while (queue.length) {
        const [x, y] = queue.shift();
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && mat[nx][ny] > mat[x][y] + 1) {
                mat[nx][ny] = mat[x][y] + 1;
                queue.push([nx, ny]);
            }
        }
    }

    return mat;
};