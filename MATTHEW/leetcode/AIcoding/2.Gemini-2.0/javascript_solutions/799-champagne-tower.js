var champagneTower = function(poured, query_row, query_glass) {
    const tower = Array(query_row + 1).fill(null).map(() => Array(query_row + 1).fill(0));
    tower[0][0] = poured;

    for (let i = 0; i < query_row; i++) {
        for (let j = 0; j <= i; j++) {
            if (tower[i][j] > 1) {
                const overflow = (tower[i][j] - 1) / 2;
                tower[i+1][j] += overflow;
                tower[i+1][j+1] += overflow;
                tower[i][j] = 1;
            }
        }
    }

    return Math.min(1, tower[query_row][query_glass]);
};