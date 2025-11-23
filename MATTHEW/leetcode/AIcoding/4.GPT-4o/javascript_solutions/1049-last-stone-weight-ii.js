var lastStoneWeightII = function(stones) {
    const totalWeight = stones.reduce((a, b) => a + b, 0);
    const target = Math.floor(totalWeight / 2);
    const dp = new Array(target + 1).fill(0);

    for (let stone of stones) {
        for (let j = target; j >= stone; j--) {
            dp[j] = Math.max(dp[j], dp[j - stone] + stone);
        }
    }

    return totalWeight - 2 * dp[target];
};