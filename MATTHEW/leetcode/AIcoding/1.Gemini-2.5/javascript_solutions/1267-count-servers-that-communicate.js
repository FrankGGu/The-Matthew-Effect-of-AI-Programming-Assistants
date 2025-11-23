var countServers = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const rowCounts = new Array(m).fill(0);
    const colCounts = new Array(n).fill(0);

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                rowCounts[r]++;
                colCounts[c]++;
            }
        }
    }

    let communicatingServers = 0;
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                if (rowCounts[r] > 1 || colCounts[c] > 1) {
                    communicatingServers++;
                }
            }
        }
    }

    return communicatingServers;
};