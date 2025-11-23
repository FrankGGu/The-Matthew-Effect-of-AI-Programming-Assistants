var maximumXOR = function(nums) {
    let xorSum = 0;
    for (let i = 0; i < nums.length; i++) {
        xorSum ^= nums[i];
    }
    return xorSum;
};