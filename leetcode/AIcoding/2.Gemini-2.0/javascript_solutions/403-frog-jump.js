var canCross = function(stones) {
    const n = stones.length;
    const dp = new Array(n).fill(null).map(() => new Set());
    dp[0].add(0);

    for (let i = 0; i < n; i++) {
        for (let k of dp[i]) {
            for (let step = k - 1; step <= k + 1; step++) {
                if (step > 0) {
                    for (let j = i + 1; j < n; j++) {
                        if (stones[j] === stones[i] + step) {
                            dp[j].add(step);
                        }
                    }
                }
            }
        }
    }

    return dp[n - 1].size > 0;
};