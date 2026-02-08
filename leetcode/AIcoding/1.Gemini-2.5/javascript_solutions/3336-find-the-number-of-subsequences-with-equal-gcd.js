function findNumberOfSubsequencesWithEqualGCD(nums, k) {
    const MAX_VAL = 200000;
    const freq = new Array(MAX_VAL + 1).fill(0);
    for (const num of nums) {
        freq[num]++;
    }

    const dp = new Array(MAX_VAL + 1).fill(0);

    for (let g = MAX_VAL; g >= k; g--) {
        if (g % k !== 0) {
            continue;
        }

        let totalElementsMultipleOfG = 0;
        for (let multiple = g; multiple <= MAX_VAL; multiple += g) {
            totalElementsMultipleOfG += freq[multiple];
        }

        if (totalElementsMultipleOfG === 0) {
            dp[g] = 0;
        } else {
            dp[g] = Math.pow(2, totalElementsMultipleOfG) - 1;

            for (let multipleG = 2 * g; multipleG <= MAX_VAL; multipleG += g) {
                dp[g] -= dp[multipleG];
            }
        }
    }

    return dp[k];
}