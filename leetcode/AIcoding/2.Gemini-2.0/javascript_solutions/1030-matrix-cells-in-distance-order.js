var allCellsDistOrder = function(rows, cols, rCenter, cCenter) {
    const cells = [];
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            cells.push([i, j]);
        }
    }

    cells.sort((a, b) => {
        const distA = Math.abs(a[0] - rCenter) + Math.abs(a[1] - cCenter);
        const distB = Math.abs(b[0] - rCenter) + Math.abs(b[1] - cCenter);
        return distA - distB;
    });

    return cells;
};