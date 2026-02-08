#include <string>
#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int palindromePartition(std::string s, int k) {
        int n = s.length();

        // Precompute the cost to make any substring s[i...j] a palindrome.
        // palindrome_cost[i][j] stores the minimum character changes needed
        // for the substring s.substr(i, j - i + 1).
        std::vector<std::vector<int>> palindrome_cost(n, std::vector<int>(n));
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int changes = 0;
                int left = i;
                int right = j;
                while (left < right) {
                    if (s[left] != s[right]) {
                        changes++;
                    }
                    left++;
                    right--;
                }
                palindrome_cost[i][j] = changes;
            }
        }

        // dp[i][k_count] stores the minimum changes to partition
        // the prefix s[0...i-1] (length i) into k_count palindromic substrings.
        // i ranges from 0 to n (length of the prefix).
        // k_count ranges from 0 to k (number of partitions).
        // Initialize with a value representing infinity (n + 1 is a safe upper bound for total changes).
        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(k + 1, n + 1));

        // Base case: An empty prefix (length 0) requires 0 partitions and 0 changes.
        dp[0][0] = 0;

        // Iterate over all possible prefix lengths (from 1 to n).
        for (int i = 1; i <= n; ++i) {
            // Iterate over all possible numbers of partitions (from 1 to k).
            for (int k_count = 1; k_count <= k; ++k_count) {
                // To form k_count partitions for the prefix s[0...i-1]:
                // The last partition is a substring s[prev_len ... i-1].
                // The preceding prefix s[0...prev_len-1] must be partitioned into k_count-1 parts.
                // 'prev_len' represents the length of the prefix that forms k_count-1 partitions.
                //
                // Constraints for 'prev_len':
                // 1. 'prev_len' must be at least k_count-1, because we need
                //    k_count-1 non-empty substrings for the prefix s[0...prev_len-1].
                // 2. 'prev_len' must be less than 'i', because the last substring
                //    s[prev_len ... i-1] must be non-empty.
                for (int prev_len = k_count - 1; prev_len < i; ++prev_len) {
                    // Check if the previous state (dp[prev_len][k_count - 1]) is reachable.
                    if (dp[prev_len][k_count - 1] != n + 1) {
                        // Calculate the cost for the current partition:
                        // cost = changes for s[0...prev_len-1] into k_count-1 parts
                        //        + changes for s[prev_len...i-1] to be a palindrome.
                        dp[i][k_count] = std::min(dp[i][k_count], 
                                                dp[prev_len][k_count - 1] + palindrome_cost[prev_len][i - 1]);
                    }
                }
            }
        }

        // The result is the minimum changes for the entire string s (length n)
        // partitioned into k palindromic substrings.
        return dp[n][k];
    }
};