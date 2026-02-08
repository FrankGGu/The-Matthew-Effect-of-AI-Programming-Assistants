var reconstructMatrix = function(upper, lower, colsum) {
    let n = colsum.length;
    let matrix = [[], []];

    for (let i = 0; i < n; i++) {
        if (colsum[i] === 2) {
            upper--;
            lower--;
            matrix[0][i] = 1;
            matrix[1][i] = 1;
        } else if (colsum[i] === 0) {
            matrix[0][i] = 0;
            matrix[1][i] = 0;
        }
    }

    for (let i = 0; i < n; i++) {
        if (colsum[i] === 1) {
            if (upper > lower) {
                upper--;
                matrix[0][i] = 1;
                matrix[1][i] = 0;
            } else {
                lower--;
                matrix[0][i] = 0;
                matrix[1][i] = 1;
            }
        }
    }

    if (upper === 0 && lower === 0) {
        return matrix;
    } else {
        return [];
    }
};