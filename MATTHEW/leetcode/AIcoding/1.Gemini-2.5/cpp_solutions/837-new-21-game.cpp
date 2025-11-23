#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    double new21Game(int n, int k, int maxPts) {
        // If Alice stops at score 0, she wins if n >= 0.
        // Since n is always non-negative, if k=0, she always wins.
        if (k == 0) {
            return 1.0;
        }

        // If the maximum possible score Alice can reach while stopping (k-1 + maxPts)
        // is less than or equal to n, then she is guaranteed to win once she reaches k.
        // The highest score she can get is (k-1) + maxPts.
        // If (k-1) + maxPts <= n, then any score she stops at (from k to k-1+maxPts)
        // will be a winning score.
        if (k + maxPts - 1 <= n) {
            return 1.0;
        }

        // dp[i] will store the probability of Alice having exactly score i.
        std::vector<double> dp(n + 1, 0.0);
        dp[0] = 1.0;

        // current_sum_of_probs represents the sum of dp[j] for scores j
        // from which Alice would draw another card (i.e., j < k)
        // and which are within the range to reach the current score i
        // (i.e., i - maxPts <= j <= i - 1).
        // Initially, for i=1, the only score that can lead to it is dp[0].
        double current_sum_of_probs = 1.0; 

        // ans will accumulate the probabilities of winning scores.
        double ans = 0.0;

        for (int i = 1; i <= n; ++i) {
            // The probability of reaching score i is the sum of probabilities
            // of reaching previous scores (j) from which Alice would draw,
            // divided by maxPts (since each card has 1/maxPts probability).
            dp[i] = current_sum_of_probs / maxPts;

            // If Alice's score is k or more, she stops.
            // If this score i is also less than or equal to n, she wins.
            if (i >= k) {
                ans += dp[i];
            }

            // Update current_sum_of_probs for the next iteration (i+1).
            // If Alice's current score i is less than k, she draws another card.
            // So, dp[i] contributes to the sum for future draws.
            if (i < k) {
                current_sum_of_probs += dp[i];
            }

            // Remove dp[i - maxPts] from current_sum_of_probs if it was part of the sum.
            // This score (i - maxPts) is now too far back to contribute to dp[i+1].
            if (i - maxPts >= 0) {
                // Only remove if dp[i - maxPts] was originally added to the sum.
                // It was added if (i - maxPts) < k.
                if (i - maxPts < k) {
                    current_sum_of_probs -= dp[i - maxPts];
                }
            }
        }

        return ans;
    }
};