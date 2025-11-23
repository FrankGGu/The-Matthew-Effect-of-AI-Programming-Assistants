function maxIncreasingCells(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;

    const valToCells = new Map();
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            const val = matrix[r][c];
            if (!valToCells.has(val)) {
                valToCells.set(val, []);
            }
            valToCells.get(val).push([r, c]);
        }
    }

    const sortedUniqueValues = Array.from(valToCells.keys()).sort((a, b) => a - b);

    const rowMax = new Array(m).fill(0);
    const colMax = new Array(n).fill(0);

    let overallMaxPath = 0;

    for (const val of sortedUniqueValues) {
        const cellsWithVal = valToCells.get(val);

        const currentBatchDp = []; 

        for (const [r, c] of cellsWithVal) {
            const prevMaxPath = Math.max(rowMax[r], colMax[c]);
            currentBatchDp.push([r, c, 1 + prevMaxPath]);
        }

        for (const [r, c, dpVal] of currentBatchDp) {
            rowMax[r] = Math.max(rowMax[r], dpVal);
            colMax[c] = Math.max(colMax[c], dpVal);
            overallMaxPath = Math.max(overallMaxPath, dpVal);
        }
    }

    return overallMaxPath;
}