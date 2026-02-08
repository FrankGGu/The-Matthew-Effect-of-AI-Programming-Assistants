var numSubmatrixSumTarget = function(matrix, target) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    let count = 0;

    for (let i = 0; i < rows; i++) {
        const prefixSum = new Array(cols).fill(0);
        for (let j = i; j < rows; j++) {
            const sumMap = new Map();
            sumMap.set(0, 1);
            let currentSum = 0;
            for (let k = 0; k < cols; k++) {
                prefixSum[k] += matrix[j][k];
                currentSum += prefixSum[k];
                if (sumMap.has(currentSum - target)) {
                    count += sumMap.get(currentSum - target);
                }
                sumMap.set(currentSum, (sumMap.get(currentSum) || 0) + 1);
            }
        }
    }

    return count;
};