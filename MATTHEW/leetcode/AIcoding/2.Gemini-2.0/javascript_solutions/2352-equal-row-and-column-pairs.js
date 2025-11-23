var equalPairs = function(grid) {
    let n = grid.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let isEqual = true;
            for (let k = 0; k < n; k++) {
                if (grid[i][k] !== grid[k][j]) {
                    isEqual = false;
                    break;
                }
            }
            if (isEqual) {
                count++;
            }
        }
    }
    return count;
};