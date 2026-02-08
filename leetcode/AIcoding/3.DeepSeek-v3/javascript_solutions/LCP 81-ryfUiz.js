var getMaximumXor = function(nums, maximumBit) {
    const n = nums.length;
    const maxK = (1 << maximumBit) - 1;
    const result = [];
    let xorSum = 0;

    for (let num of nums) {
        xorSum ^= num;
    }

    for (let i = n - 1; i >= 0; i--) {
        result.push(xorSum ^ maxK);
        xorSum ^= nums[i];
    }

    return result;
};