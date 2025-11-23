var differenceOfDistinctValues = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const ans = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            // Calculate distinct values on top-left diagonal
            const topLeftSet = new Set();
            for (let k = 1; r - k >= 0 && c - k >= 0; k++) {
                topLeftSet.add(grid[r - k][c - k]);
            }
            const count1 = topLeftSet.size;

            // Calculate distinct values on bottom-right diagonal
            const bottomRightSet = new Set();
            for (let k = 1; r + k < m && c + k < n; k++) {
                bottomRightSet.add(grid[r + k][c + k]);
            }
            const count2 = bottomRightSet.size;

            ans[r][c] = Math.abs(count1 - count2);
        }
    }

    return ans;
};