var moveZeroes = function(nums) {
    let nonZeroIndex = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] !== 0) {
            nums[nonZeroIndex] = nums[i];
            if (i !== nonZeroIndex) {
                nums[i] = 0;
            }
            nonZeroIndex++;
        }
    }
};