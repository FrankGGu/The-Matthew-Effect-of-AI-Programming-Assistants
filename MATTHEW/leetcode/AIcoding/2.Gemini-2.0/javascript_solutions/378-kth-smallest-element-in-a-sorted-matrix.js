var kthSmallest = function(matrix, k) {
    const n = matrix.length;
    const nums = [];
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            nums.push(matrix[i][j]);
        }
    }
    nums.sort((a, b) => a - b);
    return nums[k - 1];
};