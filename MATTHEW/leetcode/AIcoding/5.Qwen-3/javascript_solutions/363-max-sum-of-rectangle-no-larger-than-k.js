function maxSumSubmatrix(matrix, k) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    let maxSum = -Infinity;

    for (let left = 0; left < cols; left++) {
        const temp = new Array(rows).fill(0);
        for (let right = left; right < cols; right++) {
            for (let i = 0; i < rows; i++) {
                temp[i] += matrix[i][right];
            }

            const sorted = [0];
            let currentSum = 0;
            let minDiff = Infinity;

            for (const num of temp) {
                currentSum += num;
                const target = currentSum - k;
                const index = binarySearch(sorted, target);
                if (index !== -1) {
                    minDiff = Math.min(minDiff, currentSum - sorted[index]);
                }
                insert(sorted, currentSum);
            }

            if (minDiff !== Infinity) {
                maxSum = Math.max(maxSum, currentSum - minDiff);
            }
        }
    }

    return maxSum;
}

function binarySearch(arr, target) {
    let left = 0;
    let right = arr.length - 1;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] === target) return mid;
        else if (arr[mid] < target) left = mid + 1;
        else right = mid - 1;
    }
    return -1;
}

function insert(arr, value) {
    let left = 0;
    let right = arr.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < value) left = mid + 1;
        else right = mid;
    }
    arr.splice(left, 0, value);
}