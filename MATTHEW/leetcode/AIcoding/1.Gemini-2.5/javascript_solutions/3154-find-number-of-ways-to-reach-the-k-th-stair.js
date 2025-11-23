var waysToReachStair = function(k) {
    const memo = new Map();

    // Maximum consecutive upward jumps exponent to consider.
    // For k=30, 2^5 = 32. So jumps up to 5 are directly relevant.
    // Jumps up to 6 (2^6 = 64) might be needed if we overshoot and then go down.
    // Setting a fixed small bound like 6 is sufficient for k <= 30.
    const MAX_JUMPS_EXPONENT = 6; 

    // Maximum stair position to consider.
    // The maximum stair we can reach from 0 by only jumping up to MAX_JUMPS_EXPONENT is
    // 0 + 2^0 + 2^1 + ... + 2^MAX_JUMPS_EXPONENT = 2^(MAX_JUMPS_EXPONENT + 1) - 1.
    // For MAX_JUMPS_EXPONENT = 6, this is 2^7 - 1 = 127.
    // If stair exceeds this, it is considered too far to reach k efficiently.
    const MAX_STAIR_VALUE = 127;

    function dfs(stair, jumps) {
        // Pruning conditions:
        // If stair is negative, it's an invalid state.
        if (stair < 0) {
            return 0;
        }
        // If stair is too high, it's too far to efficiently reach k.
        // This bound is crucial to prevent exploring irrelevant states.
        if (stair > MAX_STAIR_VALUE) {
            return 0;
        }
        // If jumps exponent is too high, 2^jumps will be excessively large.
        if (jumps > MAX_JUMPS_EXPONENT) {
            return 0;
        }

        // If we reached k, this is one valid way.
        // We stop exploring this path further once k is reached.
        if (stair === k) {
            return 1;
        }

        const key = `${stair},${jumps}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        // Mark as visited with 0 temporarily to detect cycles and prevent infinite recursion.
        // If a cycle is detected and it doesn't lead to k, it contributes 0 ways.
        memo.set(key, 0); 

        let ways = 0;

        // Option 1: Go down
        // Can only go down if stair > 0.
        // Going down resets consecutive upward jumps count to 0.
        if (stair > 0) {
            ways += dfs(stair - 1, 0);
        }

        // Option 2: Go up
        // Go up to stair + 2^jumps. Increment jumps count.
        ways += dfs(stair + (1 << jumps), jumps + 1);

        // Store the actual computed ways for this state.
        memo.set(key, ways); 
        return ways;
    }

    // Start at stair 0 with 0 consecutive upward jumps.
    return dfs(0, 0);
};