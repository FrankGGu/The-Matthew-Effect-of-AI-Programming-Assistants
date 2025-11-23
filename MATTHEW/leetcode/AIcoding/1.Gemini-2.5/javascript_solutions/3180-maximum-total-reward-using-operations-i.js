var maxTotalReward = function(reward) {
    reward.sort((a, b) => a - b);

    // The maximum possible reward is bounded.
    // If we can form all sums up to S, and we consider a reward r,
    // if r <= S+1, we can form all sums up to S+r.
    // However, the condition is current_reward < r.
    // The largest sum 's' we can use to add 'r' is 'r - 1'.
    // So the maximum new sum we can form with 'r' is (r - 1) + r = 2r - 1.
    // Thus, the overall maximum reward cannot exceed 2 * max(reward[i]) - 1.
    // Given max reward[i] is 1000, max total reward is at most 2 * 1000 - 1 = 1999.
    const MAX_POSSIBLE_REWARD_VALUE = 2000; // Array size up to 1999, so index 1999 needs to be accessible.

    // dp[s] is true if sum 's' is achievable, false otherwise.
    let dp = new Array(MAX_POSSIBLE_REWARD_VALUE + 1).fill(false);
    dp[0] = true; // Starting with 0 reward is always possible.

    let currentMaxReachableSum = 0; // Tracks the maximum sum currently achievable.

    for (let r of reward) {
        // Iterate downwards to ensure that each 'r' is used at most once
        // within this iteration. If we iterate upwards, a newly set dp[s + r] = true
        // could be used in the same iteration with the same 'r', which is incorrect.
        for (let s = currentMaxReachableSum; s >= 0; s--) {
            if (dp[s] && s < r) {
                // If sum 's' is reachable and 's' is strictly less than 'r',
                // then 's + r' becomes a new reachable sum.
                dp[s + r] = true;
                // Update the maximum reachable sum.
                currentMaxReachableSum = Math.max(currentMaxReachableSum, s + r);
            }
        }
    }

    return currentMaxReachableSum;
};