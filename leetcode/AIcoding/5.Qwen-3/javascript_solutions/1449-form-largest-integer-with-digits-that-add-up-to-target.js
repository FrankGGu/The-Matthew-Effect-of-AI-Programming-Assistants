function largestNumber(cost, target) {
    const dp = Array(target + 1).fill(-1);
    dp[0] = 0;

    for (let i = 0; i < 9; i++) {
        for (let j = cost[i]; j <= target; j++) {
            if (dp[j - cost[i]] !== -1) {
                dp[j] = Math.max(dp[j], dp[j - cost[i]] + 1);
            }
        }
    }

    if (dp[target] === -1) return "0";

    let res = "";
    for (let i = 8; i >= 0; i--) {
        while (target >= cost[i] && dp[target] === dp[target - cost[i]] + 1) {
            res += (i + 1).toString();
            target -= cost[i];
        }
    }

    return res || "0";
}