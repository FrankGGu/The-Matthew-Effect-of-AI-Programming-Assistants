function diagonalSort(mat) {
    const m = mat.length, n = mat[0].length;
    const diagonals = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            if (!diagonals.has(key)) {
                diagonals.set(key, []);
            }
            diagonals.get(key).push(mat[i][j]);
        }
    }

    for (const key of diagonals.keys()) {
        diagonals.get(key).sort((a, b) => a - b);
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            mat[i][j] = diagonals.get(key).shift();
        }
    }

    return mat;
}