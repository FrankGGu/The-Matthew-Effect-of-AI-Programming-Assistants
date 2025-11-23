var findRotation = function(mat, target) {
    const n = mat.length;
    let rotated = mat;
    for (let k = 0; k < 4; k++) {
        if (isEqual(rotated, target)) {
            return true;
        }
        rotated = rotate(rotated);
    }
    return false;
};

function rotate(matrix) {
    const n = matrix.length;
    const rotated = Array.from({ length: n }, () => new Array(n).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            rotated[j][n - 1 - i] = matrix[i][j];
        }
    }
    return rotated;
}

function isEqual(a, b) {
    const n = a.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (a[i][j] !== b[i][j]) {
                return false;
            }
        }
    }
    return true;
}