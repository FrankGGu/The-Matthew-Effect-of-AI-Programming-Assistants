var numSubmatrixSumLessThanK = function(matrix, k) {
    const m = matrix.length, n = matrix[0].length;
    let count = 0;

    for (let left = 0; left < n; left++) {
        const sums = new Array(m).fill(0);
        for (let right = left; right < n; right++) {
            for (let i = 0; i < m; i++) {
                sums[i] += matrix[i][right];
            }
            count += countSubarrays(sums, k);
        }
    }

    return count;
};

function countSubarrays(sums, k) {
    const prefixSum = new Map();
    prefixSum.set(0, 1);
    let currentSum = 0, count = 0;

    for (const sum of sums) {
        currentSum += sum;
        for (const [key] of prefixSum) {
            if (currentSum - key < k) {
                count += prefixSum.get(key);
            }
        }
        prefixSum.set(currentSum, (prefixSum.get(currentSum) || 0) + 1);
    }

    return count;
}