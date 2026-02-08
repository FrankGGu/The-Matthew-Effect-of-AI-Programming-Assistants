var getMaximumXor = function(nums, maximumBit) {
    const n = nums.length;
    const maxXor = (1 << maximumBit) - 1;
    const result = new Array(n);
    let xor = 0;
    for (let i = 0; i < n; i++) {
        xor ^= nums[i];
        result[n - 1 - i] = xor ^ maxXor;
    }
    return result;
};