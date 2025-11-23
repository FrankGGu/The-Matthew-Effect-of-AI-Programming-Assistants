var reconstructMatrix = function(upper, lower, colsum) {
    const n = colsum.length;
    const result = Array(2).fill(0).map(() => Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        if (colsum[j] === 2) {
            result[0][j] = 1;
            result[1][j] = 1;
            upper--;
            lower--;
        }
    }

    if (upper < 0 || lower < 0) {
        return [];
    }

    for (let j = 0; j < n; j++) {
        if (colsum[j] === 1) {
            if (upper > 0) {
                result[0][j] = 1;
                upper--;
            } else if (lower > 0) {
                result[1][j] = 1;
                lower--;
            } else {
                return [];
            }
        }
    }

    if (upper === 0 && lower === 0) {
        return result;
    } else {
        return [];
    }
};