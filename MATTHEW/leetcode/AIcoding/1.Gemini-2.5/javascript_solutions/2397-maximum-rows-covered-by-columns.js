var maximumRows = function(mat, cols) {
    const m = mat.length;
    const n = mat[0].length;

    const rowMasks = new Array(m);
    for (let r = 0; r < m; r++) {
        let currentMask = 0;
        for (let c = 0; c < n; c++) {
            if (mat[r][c] === 1) {
                currentMask |= (1 << c);
            }
        }
        rowMasks[r] = currentMask;
    }

    let maxCoveredRows = 0;

    for (let i = 0; i < (1 << n); i++) {
        let setBitsCount = 0;
        for (let j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                setBitsCount++;
            }
        }

        if (setBitsCount !== cols) {
            continue;
        }

        let currentCoveredRows = 0;
        for (let r = 0; r < m; r++) {
            if ((rowMasks[r] & i) === rowMasks[r]) {
                currentCoveredRows++;
            }
        }
        maxCoveredRows = Math.max(maxCoveredRows, currentCoveredRows);
    }

    return maxCoveredRows;
};