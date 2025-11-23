function champagneTower(poured, query row, query col) {
    let tower = [[poured]];
    while (true) {
        let nextRow = [];
        for (let i = 0; i < tower[tower.length - 1].length; i++) {
            let overflow = tower[tower.length - 1][i] - 1;
            if (overflow > 0) {
                nextRow[i] = (nextRow[i] || 0) + overflow / 2;
                nextRow[i + 1] = (nextRow[i + 1] || 0) + overflow / 2;
            }
        }
        if (nextRow.length === 0) break;
        tower.push(nextRow);
    }
    return tower[query row][query col] || 0;
}