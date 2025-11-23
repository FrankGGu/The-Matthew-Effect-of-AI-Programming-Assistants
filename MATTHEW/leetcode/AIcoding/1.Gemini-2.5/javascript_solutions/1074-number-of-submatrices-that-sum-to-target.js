function numSubmatrixSumTarget(matrix, target) {
    const m = matrix.length;
    const n = matrix[0].length;
    let count = 0;

    for (let r1 = 0; r1 < m; r1++) {
        const currentColumnSums = new Array(n).fill(0);
        for (let r2 = r1; r2 < m; r2++) {
            for (let c = 0; c < n; c++) {
                currentColumnSums[c] += matrix[r2][c];
            }

            const prefixSumMap = new Map();
            prefixSumMap.set(0, 1);
            let currentSum = 0;

            for (let c = 0; c < n; c++) {
                currentSum += currentColumnSums[c];
                if (prefixSumMap.has(currentSum - target)) {
                    count += prefixSumMap.get(currentSum - target);
                }
                prefixSumMap.set(currentSum, (prefixSumMap.get(currentSum) || 0) + 1);
            }
        }
    }

    return count;
}