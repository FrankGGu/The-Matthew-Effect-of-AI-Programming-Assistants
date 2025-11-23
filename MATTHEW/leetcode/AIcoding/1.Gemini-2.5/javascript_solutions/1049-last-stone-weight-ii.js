var lastStoneWeightII = function(stones) {
    let totalSum = 0;
    for (const stone of stones) {
        totalSum += stone;
    }

    const target = Math.floor(totalSum / 2);
    const dp = new Array(target + 1).fill(false);
    dp[0] = true;

    for (const stone of stones) {
        for (let j = target; j >= stone; j--) {
            if (dp[j - stone]) {
                dp[j] = true;
            }
        }
    }

    let s1 = 0;
    for (let i = target; i >= 0; i--) {
        if (dp[i]) {
            s1 = i;
            break;
        }
    }

    return totalSum - 2 * s1;
};