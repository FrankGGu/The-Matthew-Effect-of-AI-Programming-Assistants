function matrixSum(nums) {
    const m = nums.length;
    const n = nums[0].length;

    for (let i = 0; i < m; i++) {
        nums[i].sort((a, b) => b - a);
    }

    let sum = 0;
    for (let j = 0; j < n; j++) {
        let max = 0;
        for (let i = 0; i < m; i++) {
            if (nums[i][j] > max) {
                max = nums[i][j];
            }
        }
        sum += max;
    }

    return sum;
}