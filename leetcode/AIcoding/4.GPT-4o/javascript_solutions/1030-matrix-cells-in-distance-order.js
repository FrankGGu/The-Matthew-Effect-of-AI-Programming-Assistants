function allCellsDistOrder(R, C, r0, c0) {
    const cells = [];
    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            cells.push([r, c]);
        }
    }
    cells.sort((a, b) => {
        const distA = Math.abs(a[0] - r0) + Math.abs(a[1] - c0);
        const distB = Math.abs(b[0] - r0) + Math.abs(b[1] - c0);
        return distA - distB;
    });
    return cells;
}