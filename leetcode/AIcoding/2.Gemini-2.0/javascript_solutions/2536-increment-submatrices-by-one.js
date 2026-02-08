var rangeAddQueries = function(n, queries) {
    const matrix = Array(n).fill(null).map(() => Array(n).fill(0));

    for (const query of queries) {
        const row1 = query[0];
        const col1 = query[1];
        const row2 = query[2];
        const col2 = query[3];

        for (let i = row1; i <= row2; i++) {
            for (let j = col1; j <= col2; j++) {
                matrix[i][j]++;
            }
        }
    }

    return matrix;
};