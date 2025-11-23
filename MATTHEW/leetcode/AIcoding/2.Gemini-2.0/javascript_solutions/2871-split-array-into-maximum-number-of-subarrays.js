var maxSubarrays = function(nums) {
    let result = 1;
    let currentAnd = nums[0];
    for (let i = 1; i < nums.length; i++) {
        currentAnd &= nums[i];
    }
    if (currentAnd !== 0) {
        return 1;
    }
    currentAnd = nums[0];
    for (let i = 1; i < nums.length; i++) {
        currentAnd &= nums[i];
        if (currentAnd === 0) {
            result++;
            if (i + 1 < nums.length) {
                currentAnd = nums[i + 1];
                i++;
            }
        }
    }
    return result;
};