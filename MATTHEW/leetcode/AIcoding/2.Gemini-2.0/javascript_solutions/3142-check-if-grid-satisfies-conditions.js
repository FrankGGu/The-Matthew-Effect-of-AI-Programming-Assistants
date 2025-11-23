var checkValidGrid = function(grid) {
    if (grid[0][0] !== 0) return false;
    const n = grid.length;
    let x = 0, y = 0, num = 0;

    while (num < n * n - 1) {
        let found = false;
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === num + 1 && Math.abs(i - x) + Math.abs(j - y) === 1) {
                    x = i;
                    y = j;
                    num++;
                    found = true;
                    break;
                }
            }
            if (found) break;
        }
        if (!found) return false;
    }

    return true;
};