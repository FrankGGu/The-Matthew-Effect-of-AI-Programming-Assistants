var maxSumSubmatrix = function(matrix, k) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    let maxSum = -Infinity;

    for (let left = 0; left < cols; left++) {
        const rowSums = new Array(rows).fill(0);

        for (let right = left; right < cols; right++) {
            for (let row = 0; row < rows; row++) {
                rowSums[row] += matrix[row][right];
            }

            let currentSum = 0;
            let sortedSums = [0];

            for (let sum of rowSums) {
                currentSum += sum;
                let low = 0;
                let high = sortedSums.length - 1;
                let potential = Infinity;

                while (low <= high) {
                    let mid = Math.floor((low + high) / 2);
                    if (sortedSums[mid] <= currentSum - k) {
                        potential = sortedSums[mid];
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }

                if (potential !== Infinity) {
                    maxSum = Math.max(maxSum, currentSum - potential);
                }

                low = 0;
                high = sortedSums.length - 1;

                while (low <= high) {
                    let mid = Math.floor((low + high) / 2);
                    if (sortedSums[mid] < currentSum) {
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }

                sortedSums.splice(low, 0, currentSum);
            }
        }
    }

    return maxSum;
};