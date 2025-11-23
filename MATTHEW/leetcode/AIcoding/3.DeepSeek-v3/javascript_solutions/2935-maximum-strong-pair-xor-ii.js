var maximumStrongPairXor = function(nums) {
    nums.sort((a, b) => a - b);
    let maxXor = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            if (Math.abs(nums[i] - nums[j]) <= Math.min(nums[i], nums[j])) {
                maxXor = Math.max(maxXor, nums[i] ^ nums[j]);
            }
        }
    }

    return maxXor;
};