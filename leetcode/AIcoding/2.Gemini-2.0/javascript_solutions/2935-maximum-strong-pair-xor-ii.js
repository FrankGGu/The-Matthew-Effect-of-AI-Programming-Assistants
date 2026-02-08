var maximumStrongPairXor = function(nums) {
    nums.sort((a, b) => a - b);
    let max_xor = 0;
    let j = 0;
    for (let i = 0; i < nums.length; i++) {
        while (j < nums.length && nums[j] <= 2 * nums[i]) {
            j++;
        }
        for (let k = i; k < j; k++) {
            if (Math.abs(nums[i] - nums[k]) <= Math.min(nums[i], nums[k])) {
                max_xor = Math.max(max_xor, nums[i] ^ nums[k]);
            }
        }
    }
    return max_xor;
};