var lastStoneWeightII = function(stones) {
    const sum = stones.reduce((a, b) => a + b, 0);
    const target = Math.floor(sum / 2);
    const dp = new Array(target + 1).fill(false);
    dp[0] = true;

    for (const stone of stones) {
        for (let j = target; j >= stone; j--) {
            dp[j] = dp[j] || dp[j - stone];
        }
    }

    for (let j = target; j >= 0; j--) {
        if (dp[j]) {
            return sum - 2 * j;
        }
    }

    return 0;
};