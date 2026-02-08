var setZeroes = function(matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;

    let firstRowZero = false;
    let firstColZero = false;

    for (let i = 0; i < cols; i++) {
        if (matrix[0][i] === 0) {
            firstRowZero = true;
            break;
        }
    }

    for (let i = 0; i < rows; i++) {
        if (matrix[i][0] === 0) {
            firstColZero = true;
            break;
        }
    }

    for (let i = 1; i < rows; i++) {
        for (let j = 1; j < cols; j++) {
            if (matrix[i][j] === 0) {
                matrix[i][0] = 0;
                matrix[0][j] = 0;
            }
        }
    }

    for (let i = 1; i < rows; i++) {
        for (let j = 1; j < cols; j++) {
            if (matrix[i][0] === 0 || matrix[0][j] === 0) {
                matrix[i][j] = 0;
            }
        }
    }

    if (firstRowZero) {
        for (let i = 0; i < cols; i++) {
            matrix[0][i] = 0;
        }
    }

    if (firstColZero) {
        for (let i = 0; i < rows; i++) {
            matrix[i][0] = 0;
        }
    }
};