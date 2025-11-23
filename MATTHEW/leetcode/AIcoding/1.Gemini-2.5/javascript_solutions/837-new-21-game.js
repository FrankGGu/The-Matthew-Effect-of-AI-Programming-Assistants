var new21Game = function(N, K, maxPts) {
    if (K === 0) {
        return 1.0;
    }

    // If N is large enough that any score Alice can possibly get (up to K-1 + maxPts)
    // is a winning score (i.e., <= N), then she will always win if she reaches K or more points.
    // The probability of reaching any score >= K is 1.0.
    // The highest score Alice can reach is K-1 + maxPts (by having K-1 points and drawing maxPts).
    // If this maximum possible score is less than or equal to N, she always wins.
    if (N >= K - 1 + maxPts) {
        return 1.0;
    }

    // dp[i] will store the probability that Alice has exactly i points.
    // The maximum score we need to calculate dp for is K-1 + maxPts,
    // because if she has K-1 points and draws maxPts, she gets K-1+maxPts.
    // Scores beyond this are not reachable by drawing from < K.
    // The array size will be K + maxPts (for indices 0 to K+maxPts-1).
    const dp = new Array(K + maxPts).fill(0);

    dp[0] = 1.0; // Alice starts with 0 points.
    let currentWindowSum = 1.0; // This sum represents sum(dp[j]) for j in [i - maxPts, i - 1] where j < K.
                                // Initially, for dp[1], this is dp[0].
    let ans = 0.0;

    // Iterate for possible scores from 1 up to K-1 + maxPts.
    // The loop condition `i < K + maxPts` covers indices up to `K + maxPts - 1`.
    for (let i = 1; i < K + maxPts; i++) {
        // The probability of reaching score i is the sum of probabilities of reaching
        // scores j (where j < K and i-maxPts <= j < i) and drawing a card of value i-j.
        // Since each card has probability 1/maxPts, dp[i] = currentWindowSum / maxPts.
        dp[i] = currentWindowSum / maxPts;

        // If Alice stops at score i and wins (i.e., K <= i <= N).
        if (i >= K && i <= N) {
            ans += dp[i];
        }

        // Update currentWindowSum for the next iteration (for dp[i+1]).
        // If Alice has score i and i < K, she can draw another card.
        // So dp[i] contributes to the sum for future calculations.
        if (i < K) {
            currentWindowSum += dp[i];
        }

        // Remove dp[i - maxPts] from the window sum if it's no longer relevant.
        // This happens if (i - maxPts) was a score from which Alice could draw cards
        // (i.e., i - maxPts >= 0 and i - maxPts < K).
        if (i - maxPts >= 0 && i - maxPts < K) {
            currentWindowSum -= dp[i - maxPts];
        }
    }

    return ans;
};