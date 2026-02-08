var shiftGrid = function(grid, k) {
    const m = grid.length, n = grid[0].length;
    k = k % (m * n);
    const flatGrid = [].concat(...grid);
    const shiftedGrid = flatGrid.slice(-k).concat(flatGrid.slice(0, -k));

    const result = [];
    for (let i = 0; i < m; i++) {
        result.push(shiftedGrid.slice(i * n, (i + 1) * n));
    }
    return result;
};