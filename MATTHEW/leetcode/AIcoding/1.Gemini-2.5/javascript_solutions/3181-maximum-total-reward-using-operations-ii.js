var maxTotalReward = function(reward) {
    reward.sort((a, b) => a - b);

    let dp = 1n; // Represents the set of achievable sums, initially {0}

    for (const r of reward) {
        // We want to add 'r' to sums 's' such that 's < r'.
        // (1n << BigInt(r)) - 1n creates a bitmask where all bits from 0 to r-1 are set.
        // dp & ((1n << BigInt(r)) - 1n) isolates the achievable sums 's' that are less than 'r'.
        // Shifting these sums by 'r' (<< BigInt(r)) effectively adds 'r' to them, creating new sums 's + r'.
        // The bitwise OR operation (|=) adds these new sums to the 'dp' bitmask.
        dp |= (dp & ((1n << BigInt(r)) - 1n)) << BigInt(r);
    }

    let maxReward = 0;
    // The maximum possible sum is bounded by roughly 2 * max(reward_value) - 1.
    // Given max reward_value is 1000, the maximum sum we need to check is around 1999.
    // Iterate downwards from this upper bound to find the largest achievable sum.
    for (let i = 1999; i >= 0; i--) { 
        if ((dp >> BigInt(i)) & 1n) {
            maxReward = i;
            break;
        }
    }

    return maxReward;
};