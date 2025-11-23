var sumOfPower = function(nums) {
    const MOD = 1e9 + 7;
    nums.sort((a, b) => a - b);
    let sum = 0;
    let dp = 0;
    let res = 0;
    for (const num of nums) {
        sum = (sum * 2) % MOD;
        res = (res + (num * num % MOD) * (sum + num) % MOD) % MOD;
        sum = (sum + num) % MOD;
    }
    return res;
};