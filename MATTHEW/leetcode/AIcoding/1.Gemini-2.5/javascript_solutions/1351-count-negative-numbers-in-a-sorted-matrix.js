var countNegatives = function(grid) {
    let count = 0;
    let m = grid.length;
    let n = grid[0].length;

    let r = 0;
    let c = n - 1;

    while (r < m && c >= 0) {
        if (grid[r][c] < 0) {
            count += (m - r);
            c--;
        } else {
            r++;
        }
    }

    return count;
};