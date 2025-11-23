var moveZeroes = function(nums) {
    let lastNonZeroIndex = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] !== 0) {
            nums[lastNonZeroIndex] = nums[i];
            lastNonZeroIndex++;
        }
    }
    for (let i = lastNonZeroIndex; i < nums.length; i++) {
        nums[i] = 0;
    }
};