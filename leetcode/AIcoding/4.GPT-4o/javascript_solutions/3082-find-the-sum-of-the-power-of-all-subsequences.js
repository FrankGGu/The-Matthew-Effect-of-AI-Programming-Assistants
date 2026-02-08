var sumOfPower = function(nums) {
    const mod = 1e9 + 7;
    nums.sort((a, b) => a - b);
    let total = 0, n = nums.length;
    let prefixSum = 0, suffixSum = 0, power = 1;

    for (let i = 0; i < n; i++) {
        total = (total + (nums[i] * power) % mod) % mod;
        power = (power * 2) % mod;
    }

    power = 1;
    for (let i = n - 1; i >= 0; i--) {
        total = (total + (nums[i] * power) % mod) % mod;
        power = (power * 2) % mod;
    }

    return total;
};