var maxTotalDamage = function(damage) {
    let maxDamageValue = 0;
    const damageCounts = new Map();

    for (const d of damage) {
        damageCounts.set(d, (damageCounts.get(d) || 0) + 1);
        if (d > maxDamageValue) {
            maxDamageValue = d;
        }
    }

    const points = new Array(maxDamageValue + 1).fill(0);
    for (const [dVal, count] of damageCounts.entries()) {
        points[dVal] = dVal * count;
    }

    const dp = new Array(maxDamageValue + 1).fill(0);

    if (maxDamageValue >= 1) {
        dp[1] = points[1];
    }

    for (let i = 2; i <= maxDamageValue; i++) {
        let option1 = dp[i - 1];
        let option2 = points[i] + (dp[i - 2] || 0);

        dp[i] = Math.max(option1, option2);
    }

    return dp[maxDamageValue];
};