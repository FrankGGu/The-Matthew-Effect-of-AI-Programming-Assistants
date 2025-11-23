var kWeakestRows = function(mat, k) {
    const rows = mat.map((row, index) => [row.reduce((a, b) => a + b, 0), index]);
    rows.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
    return rows.slice(0, k).map(row => row[1]);
};