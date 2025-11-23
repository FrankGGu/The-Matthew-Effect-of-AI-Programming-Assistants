#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int numberOfArrays(std::string s, int k) {
        int n = s.length();
        long long MOD = 1e9 + 7;

        // dp[i] will store the number of ways to restore the array from the substring s[i...n-1]
        std::vector<long long> dp(n + 1, 0);
        dp[n] = 1; // Base case: an empty string (after index n-1) has one way to be restored (by doing nothing)

        // Iterate from the end of the string backwards
        for (int i = n - 1; i >= 0; --i) {
            // If the current digit is '0', it cannot be the start of a valid number (no leading zeros)
            if (s[i] == '0') {
                dp[i] = 0;
                continue;
            }

            long long current_num = 0;
            // Iterate to form numbers starting from s[i]
            // A number can have at most 10 digits if it's <= 10^9 (since k <= 10^9).
            // This loop effectively runs at most 10 times for each 'i'.
            for (int j = i; j < n; ++j) {
                current_num = current_num * 10 + (s[j] - '0');

                // If current_num exceeds k, then any further extension will also exceed k.
                // So, we break the inner loop as no valid numbers can be formed from s[i...j] onwards.
                if (current_num > k) {
                    break;
                }

                // If current_num is valid (1 <= current_num <= k),
                // add the number of ways to restore the rest of the string (s[j+1...n-1])
                // which is stored in dp[j+1].
                dp[i] = (dp[i] + dp[j + 1]) % MOD;
            }
        }

        return dp[0]; // The result is the number of ways to restore the entire string s[0...n-1]
    }
};