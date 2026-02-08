var lastStoneWeightII = function(stones) {
    const sum = stones.reduce((a, b) => a + b, 0);
    const target = Math.floor(sum / 2);
    const n = stones.length;
    const dp = Array(target + 1).fill(false);
    dp[0] = true;

    for (let i = 0; i < n; i++) {
        for (let j = target; j >= stones[i]; j--) {
            dp[j] = dp[j] || dp[j - stones[i]];
        }
    }

    for (let j = target; j >= 0; j--) {
        if (dp[j]) {
            return sum - 2 * j;
        }
    }
};