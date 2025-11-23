var findColumnWidth = function(grid) {
    const widths = new Array(grid[0].length).fill(0);
    for (const row of grid) {
        for (let j = 0; j < row.length; j++) {
            widths[j] = Math.max(widths[j], String(row[j]).length);
        }
    }
    return widths;
};