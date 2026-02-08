var oddCells = function(m, n, indices) {
    let rows = new Array(m).fill(0);
    let cols = new Array(n).fill(0);

    for (let i = 0; i < indices.length; i++) {
        let r = indices[i][0];
        let c = indices[i][1];
        rows[r]++;
        cols[c]++;
    }

    let oddRowsCount = 0;
    for (let i = 0; i < m; i++) {
        if (rows[i] % 2 !== 0) {
            oddRowsCount++;
        }
    }

    let oddColsCount = 0;
    for (let i = 0; i < n; i++) {
        if (cols[i] % 2 !== 0) {
            oddColsCount++;
        }
    }

    let evenRowsCount = m - oddRowsCount;
    let evenColsCount = n - oddColsCount;

    return (oddRowsCount * evenColsCount) + (evenRowsCount * oddColsCount);
};