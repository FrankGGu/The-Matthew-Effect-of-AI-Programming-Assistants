var largestNumber = function(cost, target) {
    const dp = new Array(target + 1).fill(-Infinity);
    dp[0] = 0;

    for (let i = 1; i <= target; i++) {
        for (let j = 0; j < 9; j++) {
            if (i >= cost[j]) {
                dp[i] = Math.max(dp[i], dp[i - cost[j]] + 1);
            }
        }
    }

    if (dp[target] <= 0) return "0";

    let res = [];
    let remaining = target;

    for (let j = 8; j >= 0; j--) {
        while (remaining >= cost[j] && dp[remaining] === dp[remaining - cost[j]] + 1) {
            res.push(j + 1);
            remaining -= cost[j];
        }
    }

    return res.join('');
};