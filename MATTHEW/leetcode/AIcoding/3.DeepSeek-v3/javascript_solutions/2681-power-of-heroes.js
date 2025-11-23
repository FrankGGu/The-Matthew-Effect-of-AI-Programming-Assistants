var sumOfPower = function(nums) {
    const MOD = 1e9 + 7;
    nums.sort((a, b) => a - b);
    let res = 0;
    let preSum = 0;
    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const current = (preSum + num) % MOD;
        res = (res + (num * num % MOD) * current) % MOD;
        preSum = (preSum * 2 + num) % MOD;
    }
    return res;
};