var sumOfPower = function(nums) {
    const MOD = 10**9 + 7;
    nums.sort((a, b) => a - b);
    let sum = 0;
    let powerSum = 0;
    for (const num of nums) {
        powerSum = (powerSum + (num * num % MOD * (num + sum)) % MOD) % MOD;
        sum = (sum * 2 % MOD + num) % MOD;
    }
    return powerSum;
};