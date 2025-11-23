var rightTriangles = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const rowOnes = new Array(m).fill(0);
    const colOnes = new Array(n).fill(0);

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                rowOnes[r]++;
                colOnes[c]++;
            }
        }
    }

    let totalTriangles = 0;

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                const horizontalOptions = rowOnes[r] - 1;
                const verticalOptions = colOnes[c] - 1;

                if (horizontalOptions > 0 && verticalOptions > 0) {
                    totalTriangles += horizontalOptions * verticalOptions;
                }
            }
        }
    }

    return totalTriangles;
};