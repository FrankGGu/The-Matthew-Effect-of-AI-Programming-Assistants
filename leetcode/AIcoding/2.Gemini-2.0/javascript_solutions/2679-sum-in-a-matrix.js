var matrixSum = function(nums) {
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        nums[i].sort((a, b) => a - b);
    }

    for (let j = 0; j < nums[0].length; j++) {
        let max = 0;
        for (let i = 0; i < nums.length; i++) {
            max = Math.max(max, nums[i][j]);
        }
        sum += max;
    }

    return sum;
};