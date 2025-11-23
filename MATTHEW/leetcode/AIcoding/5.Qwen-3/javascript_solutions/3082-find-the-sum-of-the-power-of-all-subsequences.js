function sumOfPower(nums) {
    const MOD = 10 ** 9 + 7;
    let result = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let power = 1;
        for (let j = i + 1; j < n; j++) {
            power = (power * nums[j]) % MOD;
        }
        result = (result + nums[i] * power) % MOD;
    }

    return result;
}