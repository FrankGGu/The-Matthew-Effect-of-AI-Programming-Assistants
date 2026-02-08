var allCellsDistOrder = function(R, C, r0, c0) {
    let cellsWithDistance = [];

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            let distance = Math.abs(r - r0) + Math.abs(c - c0);
            cellsWithDistance.push([r, c, distance]);
        }
    }

    cellsWithDistance.sort((a, b) => a[2] - b[2]);

    let result = [];
    for (let i = 0; i < cellsWithDistance.length; i++) {
        result.push([cellsWithDistance[i][0], cellsWithDistance[i][1]]);
    }

    return result;
};