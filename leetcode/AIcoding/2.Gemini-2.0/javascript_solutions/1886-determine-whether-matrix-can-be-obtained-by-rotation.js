var findRotation = function(mat, target) {
    const n = mat.length;

    const rotate = (matrix) => {
        const newMatrix = Array(n).fill(null).map(() => Array(n).fill(0));
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                newMatrix[j][n - 1 - i] = matrix[i][j];
            }
        }
        return newMatrix;
    };

    const areEqual = (matrix1, matrix2) => {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (matrix1[i][j] !== matrix2[i][j]) {
                    return false;
                }
            }
        }
        return true;
    };

    if (areEqual(mat, target)) return true;

    let rotatedMat = rotate(mat);
    if (areEqual(rotatedMat, target)) return true;

    rotatedMat = rotate(rotatedMat);
    if (areEqual(rotatedMat, target)) return true;

    rotatedMat = rotate(rotatedMat);
    if (areEqual(rotatedMat, target)) return true;

    return false;
};