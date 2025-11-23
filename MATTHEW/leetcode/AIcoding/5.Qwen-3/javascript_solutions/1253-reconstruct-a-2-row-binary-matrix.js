function findMatrix(rowSum) {
    const n = rowSum.length;
    const result = [[], []];
    for (let i = 0; i < n; i++) {
        if (rowSum[i] > 0) {
            result[0].push(1);
            rowSum[i]--;
        } else {
            result[0].push(0);
        }
        if (rowSum[i] > 0) {
            result[1].push(1);
            rowSum[i]--;
        } else {
            result[1].push(0);
        }
    }
    return result;
}