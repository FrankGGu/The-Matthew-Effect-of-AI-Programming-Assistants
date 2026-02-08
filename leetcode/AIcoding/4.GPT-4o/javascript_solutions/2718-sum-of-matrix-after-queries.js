var matrixSumQueries = function(n, queries) {
    const rowSum = new Array(n).fill(0);
    const colSum = new Array(n).fill(0);
    const rowAdded = new Array(n).fill(false);
    const colAdded = new Array(n).fill(false);
    let totalSum = 0;

    for (let i = queries.length - 1; i >= 0; i--) {
        const [x, y, value] = queries[i];
        if (!rowAdded[x]) {
            totalSum += value * (n - colSum.filter(v => v > 0).length);
            rowAdded[x] = true;
            rowSum[x] += value;
        }
        if (!colAdded[y]) {
            totalSum += value * (n - rowSum.filter(v => v > 0).length);
            colAdded[y] = true;
            colSum[y] += value;
        }
    }

    return totalSum;
};