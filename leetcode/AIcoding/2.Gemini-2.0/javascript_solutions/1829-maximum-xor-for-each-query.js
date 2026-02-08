var getMaximumXor = function(nums, maximumBit) {
    const n = nums.length;
    const maxXor = (1 << maximumBit) - 1;
    const result = [];
    let currentXor = 0;
    for (let i = 0; i < n; i++) {
        currentXor ^= nums[i];
    }

    for (let i = n - 1; i >= 0; i--) {
        result.push(maxXor ^ currentXor);
        currentXor ^= nums[i];
    }

    return result;
};