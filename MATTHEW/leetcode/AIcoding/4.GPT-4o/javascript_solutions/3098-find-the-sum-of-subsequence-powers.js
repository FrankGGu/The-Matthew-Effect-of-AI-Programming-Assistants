var sumOfSubseqWidths = function(nums) {
    nums.sort((a, b) => a - b);
    let mod = 10**9 + 7;
    let n = nums.length;
    let result = 0;
    let pow2 = 1;

    for (let i = 0; i < n; i++) {
        result = (result + (pow2 * (nums[i] - nums[n - 1 - i])) % mod) % mod;
        pow2 = (pow2 * 2) % mod;
    }

    return result;
};