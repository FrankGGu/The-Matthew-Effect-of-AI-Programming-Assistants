var findFarmland = function(land) {
    const m = land.length;
    const n = land[0].length;
    const result = [];

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (land[r][c] === 1) {
                // Found the top-left corner of a farmland group
                const r1 = r;
                const c1 = c;

                // Find the bottom-right corner
                let r2 = r;
                while (r2 + 1 < m && land[r2 + 1][c] === 1) {
                    r2++;
                }

                let c2 = c;
                while (c2 + 1 < n && land[r][c2 + 1] === 1) {
                    c2++;
                }

                // Add the coordinates to the result
                result.push([r1, c1, r2, c2]);

                // Mark all cells in this farmland group as visited (0)
                // to prevent re-processing
                for (let i = r1; i <= r2; i++) {
                    for (let j = c1; j <= c2; j++) {
                        land[i][j] = 0;
                    }
                }
            }
        }
    }

    return result;
};