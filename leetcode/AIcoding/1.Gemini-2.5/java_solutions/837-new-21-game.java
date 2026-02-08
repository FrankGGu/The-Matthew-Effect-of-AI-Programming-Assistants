class Solution {
    public double new21Game(int N, int K, int maxPts) {
        if (K == 0) {
            return 1.0;
        }
        // If Alice can always score K or more, and never exceed N,
        // then the probability is 1.0.
        // The maximum score Alice can reach before stopping is K - 1 + maxPts.
        // If this maximum possible score is less than or equal to N,
        // then any score Alice stops at (which is between K and K - 1 + maxPts)
        // will be within the winning range [K, N].
        // Since she must eventually reach a score of K or more, the probability is 1.0.
        // This condition is K - 1 + maxPts <= N, which simplifies to K + maxPts <= N + 1.
        if (K + maxPts <= N + 1) {
            return 1.0;
        }

        double[] dp = new double[N + 1];
        dp[0] = 1.0;
        double currentSum = 1.0; // Represents sum of dp[j] for j in [max(0, i-maxPts), min(i-1, K-1)]
                                 // For i=1, this is dp[0].
        double ans = 0.0;

        for (int i = 1; i <= N; i++) {
            // dp[i] is the probability of having exactly 'i' points.
            // It's the sum of probabilities of reaching 'i' from previous scores 'j' (where j < K),
            // by drawing a card of value (i-j).
            // The sum is over j in [max(0, i - maxPts), min(i-1, K-1)].
            // currentSum maintains this sum.
            dp[i] = currentSum / maxPts;

            // If current score 'i' is within the winning range [K, N], add its probability to ans.
            if (i >= K) {
                ans += dp[i];
            }

            // Update currentSum for the next iteration (i+1).
            // Add dp[i] to currentSum if Alice can still draw cards from score 'i'.
            // This means 'i' must be less than K.
            if (i < K) {
                currentSum += dp[i];
            }

            // Remove dp[i - maxPts] from currentSum if it's no longer in the sliding window
            // and if it was a score from which Alice could draw (i.e., i - maxPts < K).
            if (i - maxPts >= 0 && i - maxPts < K) {
                currentSum -= dp[i - maxPts];
            }
        }

        return ans;
    }
}