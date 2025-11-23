var minSwapsCouples = function(row) {
    const n = row.length;
    const pos = new Array(n);
    for (let i = 0; i < n; i++) {
        pos[row[i]] = i;
    }
    let swaps = 0;
    for (let i = 0; i < n; i += 2) {
        let x = row[i];
        let y = x ^ 1;
        if (row[i + 1] !== y) {
            let j = pos[y];
            [row[i + 1], row[j]] = [row[j], row[i + 1]];
            pos[row[i + 1]] = i + 1;
            pos[row[j]] = j;
            swaps++;
        }
    }
    return swaps;
};