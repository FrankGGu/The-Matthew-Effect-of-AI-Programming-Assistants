var countPartitions = function(nums) {
    const MOD = 10**9 + 7;

    let totalSum = 0;
    for (let i = 0; i < nums.length; i++) {
        totalSum += nums[i];
    }

    if (totalSum % 2 !== 0) {
        return 0;
    }

    let n = nums.length;
    let result = 1;
    let base = 2;
    let exponent = n;

    while (exponent > 0) {
        if (exponent % 2 === 1) {
            result = (result * base) % MOD;
        }
        base = (base * base) % MOD;
        exponent = Math.floor(exponent / 2);
    }

    return result;
};