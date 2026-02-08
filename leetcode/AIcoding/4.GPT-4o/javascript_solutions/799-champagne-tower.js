function champagneTower poured, query_row, query_glass) {
    const tower = Array.from({ length: 101 }, () => Array(101).fill(0));
    tower[0][0] = poured;

    for (let r = 0; r <= query_row; r++) {
        for (let g = 0; g <= r; g++) {
            if (tower[r][g] > 1) {
                const overflow = (tower[r][g] - 1) / 2;
                tower[r + 1][g] += overflow;
                tower[r + 1][g + 1] += overflow;
            }
        }
    }

    return Math.min(1, tower[query_row][query_glass]);
}