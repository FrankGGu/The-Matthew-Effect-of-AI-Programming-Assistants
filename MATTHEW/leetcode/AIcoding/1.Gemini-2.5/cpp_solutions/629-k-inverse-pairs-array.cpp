#include <vector>
#include <numeric>

class Solution {
public:
    int kInversePairs(int n, int k) {
        int MOD = 1e9 + 7;

        // dp[j] will store the number of arrays with 'i' elements and 'j' inverse pairs.
        // prev_dp[j] will store the number of arrays with 'i-1' elements and 'j' inverse pairs.
        std::vector<int> dp(k + 1, 0);
        std::vector<int> prev_dp(k + 1, 0);

        // Base case: For 0 elements, there is 1 way to have 0 inverse pairs (empty array).
        prev_dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            long long current_sum = 0; // This will be the sum of dp[i-1][j-x] for x from 0 to min(j, i-1)
            for (int j = 0; j <= k; ++j) {
                // Add dp[i-1][j] to the sliding window sum
                current_sum = (current_sum + prev_dp[j]) % MOD;

                // If j >= i, we need to remove dp[i-1][j-i] from the sum.
                // This is because the maximum number of inverse pairs that can be added by placing
                // the i-th element is i-1 (placing it at the first position).
                // So, we are considering dp[i-1][j-0] + dp[i-1][j-1] + ... + dp[i-1][j-(i-1)]
                // When j increments, the window slides, adding dp[i-1][j] and removing dp[i-1][j-i].
                if (j >= i) {
                    current_sum = (current_sum - prev_dp[j - i] + MOD) % MOD;
                }
                dp[j] = current_sum;
            }
            // Update prev_dp for the next iteration (i+1)
            prev_dp = dp;
        }

        return dp[k];
    }
};