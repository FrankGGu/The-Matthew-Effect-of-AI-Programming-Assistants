var champagneTower = function(poured, query_row, query_glass) {
    let tower = Array(101).fill().map(() => Array(101).fill(0));
    tower[0][0] = poured;

    for (let row = 0; row <= query_row; row++) {
        for (let glass = 0; glass <= row; glass++) {
            let excess = (tower[row][glass] - 1) / 2;
            if (excess > 0) {
                tower[row + 1][glass] += excess;
                tower[row + 1][glass + 1] += excess;
            }
        }
    }

    return Math.min(1, tower[query_row][query_glass]);
};