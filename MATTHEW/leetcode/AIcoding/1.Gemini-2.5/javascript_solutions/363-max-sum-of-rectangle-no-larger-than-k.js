var maxSumSubmatrix = function(matrix, k) {
    let rows = matrix.length;
    if (rows === 0) return 0;
    let cols = matrix[0].length;
    if (cols === 0) return 0;

    let maxSum = -Infinity;

    let isRowMajor = true;
    let dim1 = rows;
    let dim2 = cols;

    if (rows > cols) {
        isRowMajor = false;
        dim1 = cols;
        dim2 = rows;
    }

    // Helper for binary search (lower_bound)
    function lowerBound(arr, target) {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    for (let i = 0; i < dim2; i++) {
        let rowSums = new Array(dim1).fill(0);
        for (let j = i; j < dim2; j++) {
            for (let r = 0; r < dim1; r++) {
                if (isRowMajor) {
                    rowSums[r] += matrix[r][j];
                } else {
                    rowSums[r] += matrix[j][r];
                }
            }

            let currentSum = 0;
            let sortedPrefixSums = [0];

            for (let val of rowSums) {
                currentSum += val;

                let targetForLowerBound = currentSum - k;
                let idx = lowerBound(sortedPrefixSums, targetForLowerBound);

                if (idx < sortedPrefixSums.length) {
                    maxSum = Math.max(maxSum, currentSum - sortedPrefixSums[idx]);
                }

                let insertIdx = lowerBound(sortedPrefixSums, currentSum);
                sortedPrefixSums.splice(insertIdx, 0, currentSum);
            }
        }
    }

    return maxSum;
};