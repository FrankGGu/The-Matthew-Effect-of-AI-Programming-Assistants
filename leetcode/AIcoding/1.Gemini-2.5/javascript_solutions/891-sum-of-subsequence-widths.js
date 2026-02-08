var sumSubseqWidths = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const MOD = 10 ** 9 + 7;
    let totalSum = 0;

    const powers = new Array(n);
    powers[0] = 1;
    for (let i = 1; i < n; i++) {
        powers[i] = (powers[i - 1] * 2) % MOD;
    }

    for (let i = 0; i < n; i++) {
        // Contribution of nums[i] as maximum: nums[i] * 2^i
        // Contribution of nums[i] as minimum: nums[i] * 2^(n - 1 - i)
        // The total sum is sum(nums[i] * (2^i - 2^(n-1-i)))

        let maxContribution = (nums[i] * powers[i]) % MOD;
        let minContribution = (nums[i] * powers[n - 1 - i]) % MOD;

        let term = (maxContribution - minContribution + MOD) % MOD;

        totalSum = (totalSum + term) % MOD;
    }

    return totalSum;
};