var matrixSumQueries = function(n, queries) {
    const rowSet = new Set();
    const colSet = new Set();
    let sum = 0;

    for (let i = queries.length - 1; i >= 0; i--) {
        const [type, index, val] = queries[i];
        if (type === 0) {
            if (!rowSet.has(index)) {
                sum += (n - colSet.size) * val;
                rowSet.add(index);
            }
        } else {
            if (!colSet.has(index)) {
                sum += (n - rowSet.size) * val;
                colSet.add(index);
            }
        }
    }

    return sum;
};