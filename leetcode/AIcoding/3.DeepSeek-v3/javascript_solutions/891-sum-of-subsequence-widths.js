var sumSubseqWidths = function(nums) {
    const MOD = 1e9 + 7;
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const pow2 = new Array(n).fill(1);
    for (let i = 1; i < n; i++) {
        pow2[i] = (pow2[i - 1] * 2) % MOD;
    }
    let res = 0;
    for (let i = 0; i < n; i++) {
        res = (res + nums[i] * (pow2[i] - pow2[n - 1 - i])) % MOD;
    }
    return (res + MOD) % MOD;
};