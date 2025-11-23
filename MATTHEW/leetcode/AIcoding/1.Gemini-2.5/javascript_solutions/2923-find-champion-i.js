var findChampion = function(grid) {
    const n = grid.length;

    for (let i = 0; i < n; i++) {
        let victories = 0;
        for (let j = 0; j < n; j++) {
            victories += grid[i][j];
        }
        if (victories === n - 1) {
            return i;
        }
    }
    return -1;
};