var updateMatrix = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const queue = [];
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 0) {
                queue.push([i, j]);
            } else {
                mat[i][j] = Infinity;
            }
        }
    }

    while (queue.length > 0) {
        const [i, j] = queue.shift();
        for (const [di, dj] of directions) {
            const ni = i + di;
            const nj = j + dj;
            if (ni >= 0 && ni < m && nj >= 0 && nj < n && mat[ni][nj] > mat[i][j] + 1) {
                mat[ni][nj] = mat[i][j] + 1;
                queue.push([ni, nj]);
            }
        }
    }

    return mat;
};