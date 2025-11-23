var findChampion = function(grid) {
    let n = grid.length;
    for (let i = 0; i < n; i++) {
        let isChampion = true;
        for (let j = 0; j < n; j++) {
            if (i !== j && grid[j][i] === 1) {
                isChampion = false;
                break;
            }
        }
        if (isChampion) {
            return i;
        }
    }
    return -1;
};