function reconstructMatrix(upper, lower, colsum) {
    const rows = [new Array(colsum.length).fill(0), new Array(colsum.length).fill(0)];
    for (let i = 0; i < colsum.length; i++) {
        if (colsum[i] === 2) {
            if (upper > 0 && lower > 0) {
                rows[0][i] = 1;
                rows[1][i] = 1;
                upper--;
                lower--;
            } else {
                return [];
            }
        } else if (colsum[i] === 1) {
            if (upper > 0) {
                rows[0][i] = 1;
                upper--;
            } else if (lower > 0) {
                rows[1][i] = 1;
                lower--;
            } else {
                return [];
            }
        }
    }
    return upper === 0 && lower === 0 ? rows : [];
}