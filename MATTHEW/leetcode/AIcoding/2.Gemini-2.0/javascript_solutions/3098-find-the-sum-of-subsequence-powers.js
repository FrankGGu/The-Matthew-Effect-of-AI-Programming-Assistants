var sumOfPower = function(nums) {
    nums.sort((a, b) => a - b);
    const MOD = 10**9 + 7;
    let sum = 0;
    let res = 0;
    for (let num of nums) {
        res = (res + num * (num + sum) % MOD) % MOD;
        sum = (2 * sum % MOD + num) % MOD;
    }
    return res;
};