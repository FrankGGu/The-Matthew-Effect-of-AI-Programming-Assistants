var zigzagTraversal = function(grid, k) {
    if (!grid || grid.length === 0 || grid[0].length === 0) return [];

    const m = grid.length;
    const n = grid[0].length;
    const result = [];
    let i = 0, j = 0;
    let direction = 1; // 1 for down, -1 for up

    while (result.length < m * n) {
        result.push(grid[i][j]);

        if (direction === 1) {
            if (i === m - 1) {
                j += k;
                direction = -1;
            } else if (j === 0) {
                i += 1;
                direction = -1;
            } else {
                i += 1;
                j -= 1;
            }
        } else {
            if (j === n - 1) {
                i += k;
                direction = 1;
            } else if (i === 0) {
                j += 1;
                direction = 1;
            } else {
                i -= 1;
                j += 1;
            }
        }

        if (i >= m || j >= n) break;
    }

    return result;
};