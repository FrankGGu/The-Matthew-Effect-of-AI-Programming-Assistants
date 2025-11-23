var perfectMenu = function(materials, cookbooks, k) {
    const maxStaple = materials[0];
    const maxNonStaple = materials[1];

    // dp[i][j][t] will store the maximum profit achievable with i units of staple,
    // j units of non-staple, and achieving exactly t taste points.
    // If t == k, it means achieving at least k taste points.
    // Initialize dp table with -1, representing unreachable states.
    // dp[0][0][0] is 0, meaning 0 materials, 0 taste, 0 profit is achievable.
    const dp = Array(maxStaple + 1).fill(0).map(() =>
        Array(maxNonStaple + 1).fill(0).map(() =>
            Array(k + 1).fill(-1)
        )
    );
    dp[0][0][0] = 0;

    // Iterate through each cookbook (item in 0/1 knapsack)
    for (const cookbook of cookbooks) {
        const reqStaple = cookbook[0];
        const reqNonStaple = cookbook[1];
        const taste = cookbook[2];
        const profit = cookbook[3];

        // Iterate backwards through material capacities to ensure each cookbook is used at most once (0/1 knapsack)
        for (let i = maxStaple; i >= reqStaple; i--) {
            for (let j = maxNonStaple; j >= reqNonStaple; j--) {
                // Iterate backwards through taste points.
                // The taste dimension is capped at k. If current_taste + taste_val exceeds k, it maps to index k.
                for (let t_prev = k; t_prev >= 0; t_prev--) {
                    // If the state (i - reqStaple, j - reqNonStaple, t_prev) was reachable
                    if (dp[i - reqStaple][j - reqNonStaple][t_prev] !== -1) {
                        const newTasteIdx = Math.min(k, t_prev + taste);
                        dp[i][j][newTasteIdx] = Math.max(
                            dp[i][j][newTasteIdx],
                            dp[i - reqStaple][j - reqNonStaple][t_prev] + profit
                        );
                    }
                }
            }
        }
    }

    // The maximum profit will be the maximum value in dp[i][j][k] for all i, j.
    // This is because dp[...][k] stores the max profit for achieving *at least* k taste.
    let maxTotalProfit = -1;
    for (let i = 0; i <= maxStaple; i++) {
        for (let j = 0; j <= maxNonStaple; j++) {
            maxTotalProfit = Math.max(maxTotalProfit, dp[i][j][k]);
        }
    }

    return maxTotalProfit;
};