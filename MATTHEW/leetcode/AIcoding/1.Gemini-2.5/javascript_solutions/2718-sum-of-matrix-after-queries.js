var matrixSumQueries = function(n, queries) {
    let totalSum = 0n;

    const rowsCovered = new Array(n).fill(false);
    const colsCovered = new Array(n).fill(false);

    let numRowsCovered = 0;
    let numColsCovered = 0;

    for (let i = queries.length - 1; i >= 0; i--) {
        const [type, index, val] = queries[i];
        const valBigInt = BigInt(val);

        if (type === 0) { // Row query
            if (!rowsCovered[index]) {
                rowsCovered[index] = true;
                numRowsCovered++;
                totalSum += valBigInt * BigInt(n - numColsCovered);
            }
        } else { // Column query
            if (!colsCovered[index]) {
                colsCovered[index] = true;
                numColsCovered++;
                totalSum += valBigInt * BigInt(n - numRowsCovered);
            }
        }

        if (numRowsCovered === n && numColsCovered === n) {
            break;
        }
    }

    return totalSum;
};