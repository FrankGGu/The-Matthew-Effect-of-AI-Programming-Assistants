function allCellsDistOrder(R, C, r0, c0) {
    const result = [];
    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            result.push([r, c]);
        }
    }
    result.sort((a, b) => Math.abs(a[0] - r0) + Math.abs(a[1] - c0) - (Math.abs(b[0] - r0) + Math.abs(b[1] - c0)));
    return result;
}