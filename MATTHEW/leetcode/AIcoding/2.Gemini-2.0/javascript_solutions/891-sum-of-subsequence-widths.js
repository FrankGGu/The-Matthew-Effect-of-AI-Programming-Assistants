var sumSubseqWidths = function(nums) {
    nums.sort((a, b) => a - b);
    const MOD = 10**9 + 7;
    let n = nums.length;
    let ans = 0;
    let pow = 1;

    for (let i = 0; i < n; i++) {
        ans = (ans + (nums[i] * pow) % MOD - (nums[n - i - 1] * pow) % MOD) % MOD;
        pow = (pow * 2) % MOD;
    }

    return (ans + MOD) % MOD;
};