#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    int numPermsDISequence(std::string s) {
        int n = s.length();
        long long MOD = 1e9 + 7;

        // dp_prev[j] stores the number of valid permutations of length 'len-1'
        // (using 'len-1' distinct numbers from 0 to len-2)
        // where the last element perm[len-2] is the j-th smallest among these 'len-1' numbers.
        // Initially, len = 1, so dp_prev corresponds to dp[1].
        // dp[1][0] = 1 (permutation of [0], perm[0] is 0th smallest)
        std::vector<long long> dp_prev(1, 1);

        // Iterate for 'i' from 1 to n.
        // 'i' represents the current length of the permutation minus 1 (0-indexed for s).
        // So, when i=1, we are considering permutations of length 2 (s[0] is used).
        // When i=n, we are considering permutations of length n+1 (s[n-1] is used).
        for (int i = 1; i <= n; ++i) {
            // dp_curr will store results for permutations of length 'i+1'.
            // It will have 'i+1' elements, for ranks 0 to i.
            std::vector<long long> dp_curr(i + 1, 0);

            // Calculate prefix sums for dp_prev.
            // dp_prev has 'i' elements (for ranks 0 to i-1).
            std::vector<long long> prefix_sum(i, 0);
            prefix_sum[0] = dp_prev[0];
            for (int k = 1; k < i; ++k) {
                prefix_sum[k] = (prefix_sum[k-1] + dp_prev[k]) % MOD;
            }

            char comparison_char = s[i-1]; // s[i-1] dictates relation between perm[i-1] and perm[i]

            if (comparison_char == 'I') { // perm[i-1] < perm[i]
                // perm[i] is the 'j'-th smallest among 'i+1' numbers.
                // perm[i-1] must be one of the '0' to 'j-1' smallest numbers.
                // The sum is dp_prev[0] + ... + dp_prev[j-1].
                for (int j = 0; j <= i; ++j) { // j is the rank of perm[i]
                    if (j > 0) {
                        dp_curr[j] = prefix_sum[j-1];
                    } else {
                        dp_curr[j] = 0; // If perm[i] is 0th smallest, no number can be smaller than it.
                    }
                }
            } else { // comparison_char == 'D', perm[i-1] > perm[i]
                // perm[i] is the 'j'-th smallest among 'i+1' numbers.
                // perm[i-1] must be one of the 'j' to 'i-1' smallest numbers.
                // The sum is dp_prev[j] + ... + dp_prev[i-1].
                // This is (sum of all dp_prev) - (sum of dp_prev[0] to dp_prev[j-1]).
                long long total_prev_sum = prefix_sum[i-1]; // Sum of dp_prev[0] to dp_prev[i-1]
                for (int j = 0; j <= i; ++j) { // j is the rank of perm[i]
                    long long sum_before_j = (j > 0) ? prefix_sum[j-1] : 0;
                    dp_curr[j] = (total_prev_sum - sum_before_j + MOD) % MOD;
                }
            }
            dp_prev = dp_curr; // Move to the next state
        }

        // The final dp_prev contains dp[n+1], which represents permutations of length n+1.
        // Sum all elements in dp_prev to get the total number of valid permutations.
        long long total_ans = 0;
        for (long long val : dp_prev) {
            total_ans = (total_ans + val) % MOD;
        }

        return static_cast<int>(total_ans);
    }
};