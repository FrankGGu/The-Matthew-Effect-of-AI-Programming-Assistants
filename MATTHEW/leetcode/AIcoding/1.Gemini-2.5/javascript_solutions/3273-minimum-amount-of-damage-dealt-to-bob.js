var minDamageDealtToBob = function(damage, health) {
    if (health <= 0) {
        return 0;
    }

    let maxPossibleSum = 0;
    for (let d of damage) {
        maxPossibleSum += d;
    }

    if (maxPossibleSum < health) {
        return -1;
    }

    const dp = new Array(maxPossibleSum + 1).fill(false);
    dp[0] = true;

    for (let d of damage) {
        for (let s = maxPossibleSum; s >= d; s--) {
            dp[s] = dp[s] || dp[s - d];
        }
    }

    for (let s = health; s <= maxPossibleSum; s++) {
        if (dp[s]) {
            return s;
        }
    }
};