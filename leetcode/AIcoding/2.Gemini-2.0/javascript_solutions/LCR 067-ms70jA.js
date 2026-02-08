var findMaximumXOR = function(nums) {
    let max = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            max = Math.max(max, nums[i] ^ nums[j]);
        }
    }
    return max;
};