function findRotation(matrix, target) {
    const n = matrix.length;

    const rotate = (mat) => {
        const res = Array.from({ length: n }, () => Array(n).fill(0));
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                res[j][n - 1 - i] = mat[i][j];
            }
        }
        return res;
    };

    for (let i = 0; i < 4; i++) {
        if (JSON.stringify(matrix) === JSON.stringify(target)) {
            return true;
        }
        matrix = rotate(matrix);
    }

    return false;
}