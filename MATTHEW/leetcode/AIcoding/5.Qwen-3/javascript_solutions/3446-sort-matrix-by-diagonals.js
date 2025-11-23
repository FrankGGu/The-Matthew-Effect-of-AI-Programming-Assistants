function diagonalSort(mat) {
    const m = mat.length;
    const n = mat[0].length;

    const diagonals = {};

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            if (!diagonals[key]) {
                diagonals[key] = [];
            }
            diagonals[key].push(mat[i][j]);
        }
    }

    for (const key in diagonals) {
        diagonals[key].sort((a, b) => a - b);
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            mat[i][j] = diagonals[key].shift();
        }
    }

    return mat;
}