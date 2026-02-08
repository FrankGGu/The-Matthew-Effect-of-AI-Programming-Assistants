var applyOperations = function(nums) {
    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === nums[i + 1]) {
            nums[i] *= 2;
            nums[i + 1] = 0;
        }
    }
    let nonZero = nums.filter(num => num !== 0);
    let zeros = nums.filter(num => num === 0);
    return nonZero.concat(zeros);
};