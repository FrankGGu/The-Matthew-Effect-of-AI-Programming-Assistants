var minAbsoluteDifference = function(matrix, k, x) {
    let n = matrix.length;
    let minDiff = Infinity;

    for (let i = 0; i <= n - k; i++) {
        for (let j = 0; j <= n - k; j++) {
            let nums = [];
            for (let row = i; row < i + k; row++) {
                for (let col = j; col < j + k; col++) {
                    nums.push(matrix[row][col]);
                }
            }
            nums.sort((a, b) => a - b);
            let mid = Math.floor(nums.length / 2);
            minDiff = Math.min(minDiff, Math.abs(nums[mid] - x));
        }
    }

    return minDiff;
};