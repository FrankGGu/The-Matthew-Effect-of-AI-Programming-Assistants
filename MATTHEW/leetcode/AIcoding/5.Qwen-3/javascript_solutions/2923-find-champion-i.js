function findChampion(grid) {
    const n = grid.length;
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (i !== j && grid[i][j] === 1) {
                count++;
            }
        }
        if (count === n - 1) {
            return i;
        }
    }
    return -1;
}