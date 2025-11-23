var findRotation = function(mat, target) {
    const n = mat.length;

    function isEqual(mat1, mat2) {
        for (let r = 0; r < n; r++) {
            for (let c = 0; c < n; c++) {
                if (mat1[r][c] !== mat2[r][c]) {
                    return false;
                }
            }
        }
        return true;
    }

    function rotateMatrix(matrix) {
        const rotated = Array.from({ length: n }, () => Array(n).fill(0));
        for (let r = 0; r < n; r++) {
            for (let c = 0; c < n; c++) {
                rotated[c][n - 1 - r] = matrix[r][c];
            }
        }
        return rotated;
    }

    for (let i = 0; i < 4; i++) {
        if (isEqual(mat, target)) {
            return true;
        }
        mat = rotateMatrix(mat);
    }

    return false;
};