double new21Game(int N, int K, int maxPts) {
    if (K == 0 || N >= K + maxPts) {
        return 1.0;
    }

    // dp[i] is the probability of having score i.
    // We need to store dp values up to N.
    // The maximum score Alice can reach and win with is N.
    // The maximum score she can reach before stopping is K - 1 + maxPts.
    // If N is less than K, she cannot win. But the problem constraints state K <= N, so this is not an issue.
    // The loop iterates up to N.
    // dp array size N+1 is sufficient as dp[i] depends on dp[j] where j < i.
    double dp[N + 1];

    // Initialize dp array to 0.0
    for (int i = 0; i <= N; ++i) {
        dp[i] = 0.0;
    }

    dp[0] = 1.0; // Alice starts with 0 points with 100% probability.

    // current_window_sum stores the sum of probabilities dp[j]
    // for scores j that are within the current drawing window and less than K.
    // Specifically, current_window_sum = sum(dp[j]) for j in [max(0, i - maxPts), min(i - 1, K - 1)]
    // For i=1, the window is effectively just dp[0].
    double current_window_sum = 1.0; // dp[0] is the only score < K initially.

    double ans = 0.0; // Total probability of winning.

    for (int i = 1; i <= N; ++i) {
        // The probability of reaching score i is the sum of probabilities of reaching
        // scores (i-1), (i-2), ..., (i-maxPts) and drawing the appropriate card.
        // These previous scores must be less than K for Alice to draw another card.
        dp[i] = current_window_sum / maxPts;

        // If Alice's score is K or more, she stops drawing.
        // If her score is also N or less, she wins.
        if (i >= K) {
            ans += dp[i];
        }

        // Update current_window_sum for the next iteration (i+1).
        // Add dp[i] to the window sum if Alice can continue drawing from score i (i.e., i < K).
        if (i < K) {
            current_window_sum += dp[i];
        }

        // Remove dp[i - maxPts] from the window sum if it's no longer in the window.
        // This dp[i - maxPts] would have been added to current_window_sum only if (i - maxPts) < K.
        // The condition `i - maxPts < K` ensures we only subtract probabilities that were previously added to `current_window_sum`.
        if (i - maxPts >= 0 && i - maxPts < K) {
            current_window_sum -= dp[i - maxPts];
        }
    }

    return ans;
}