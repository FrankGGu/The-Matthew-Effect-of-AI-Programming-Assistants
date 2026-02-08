function kWeakestRows(mat, k) {
    const rows = mat.map((row, index) => {
        const count = row.reduce((sum, val) => sum + val, 0);
        return { index, count };
    });

    rows.sort((a, b) => {
        if (a.count !== b.count) {
            return a.count - b.count;
        }
        return a.index - b.index;
    });

    return rows.slice(0, k).map(row => row.index);
}