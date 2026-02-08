var reconstructMatrix = function(upper, lower, colsum) {
    const n = colsum.length;
    const matrix = [[], []];
    let remainingUpper = upper;
    let remainingLower = lower;

    for (let i = 0; i < n; i++) {
        if (colsum[i] === 2) {
            matrix[0][i] = 1;
            matrix[1][i] = 1;
            remainingUpper--;
            remainingLower--;
        } else if (colsum[i] === 0) {
            matrix[0][i] = 0;
            matrix[1][i] = 0;
        } else {
            matrix[0][i] = -1;
            matrix[1][i] = -1;
        }
    }

    if (remainingUpper < 0 || remainingLower < 0) {
        return [];
    }

    for (let i = 0; i < n; i++) {
        if (colsum[i] === 1) {
            if (remainingUpper > 0) {
                matrix[0][i] = 1;
                matrix[1][i] = 0;
                remainingUpper--;
            } else if (remainingLower > 0) {
                matrix[0][i] = 0;
                matrix[1][i] = 1;
                remainingLower--;
            } else {
                return [];
            }
        }
    }

    if (remainingUpper !== 0 || remainingLower !== 0) {
        return [];
    }

    return matrix;
};