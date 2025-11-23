var canCross = function(stones) {
    const n = stones.length;
    const dp = new Array(n).fill().map(() => new Set());
    dp[0].add(0);

    for (let i = 0; i < n; i++) {
        for (const k of dp[i]) {
            for (const step of [k - 1, k, k + 1]) {
                if (step > 0) {
                    const next = stones[i] + step;
                    const idx = stones.indexOf(next);
                    if (idx !== -1) {
                        dp[idx].add(step);
                    }
                }
            }
        }
    }

    return dp[n - 1].size > 0;
};