var maximumStrongPairXor = function(nums) {
    let maxXor = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = 0; j < nums.length; j++) {
            if (Math.abs(nums[i] - nums[j]) <= Math.min(nums[i], nums[j])) {
                maxXor = Math.max(maxXor, nums[i] ^ nums[j]);
            }
        }
    }
    return maxXor;
};