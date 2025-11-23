function countSubsequencesWithEqualGCD(nums) {
    const maxGCD = Math.max(...nums);
    const freq = new Array(maxGCD + 1).fill(0);

    for (const num of nums) {
        freq[num]++;
    }

    const dp = new Array(maxGCD + 1).fill(0);

    for (let g = 1; g <= maxGCD; g++) {
        for (let multiple = g; multiple <= maxGCD; multiple += g) {
            dp[g] += freq[multiple];
        }
    }

    let result = 0;

    for (let g = 1; g <= maxGCD; g++) {
        if (dp[g] >= 2) {
            result += Math.pow(2, dp[g]) - 1 - dp[g];
        }
    }

    return result;
}