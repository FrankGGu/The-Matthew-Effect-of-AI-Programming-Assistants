var maxSumSubmatrix = function(matrix, k) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    let maxSum = -Infinity;

    for (let left = 0; left < cols; left++) {
        const rowSum = new Array(rows).fill(0);
        for (let right = left; right < cols; right++) {
            for (let i = 0; i < rows; i++) {
                rowSum[i] += matrix[i][right];
            }

            let currentSum = 0;
            const prefixSums = [0];
            let maxSubarraySum = -Infinity;

            for (const sum of rowSum) {
                currentSum += sum;
                const target = currentSum - k;
                let left = 0, right = prefixSums.length;
                while (left < right) {
                    const mid = Math.floor((left + right) / 2);
                    if (prefixSums[mid] >= target) {
                        right = mid;
                    } else {
                        left = mid + 1;
                    }
                }
                if (left < prefixSums.length) {
                    maxSubarraySum = Math.max(maxSubarraySum, currentSum - prefixSums[left]);
                }
                let insertPos = 0;
                while (insertPos < prefixSums.length && prefixSums[insertPos] < currentSum) {
                    insertPos++;
                }
                prefixSums.splice(insertPos, 0, currentSum);
            }

            if (maxSubarraySum <= k && maxSubarraySum > maxSum) {
                maxSum = maxSubarraySum;
                if (maxSum === k) return k;
            }
        }
    }

    return maxSum;
};