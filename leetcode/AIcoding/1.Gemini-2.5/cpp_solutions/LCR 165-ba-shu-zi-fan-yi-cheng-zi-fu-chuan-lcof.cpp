#include <string>
#include <vector>

class Solution {
public:
    int numDecodings(std::string s) {
        if (s.empty()) {
            return 0;
        }

        int n = s.length();

        // dp_prev2 corresponds to dp[i-2], representing ways to decode s[0...i-3]
        // dp_prev1 corresponds to dp[i-1], representing ways to decode s[0...i-2]
        // dp_curr corresponds to dp[i], representing ways to decode s[0...i-1]

        // Initialize for the base cases
        // dp[0] = 1 (empty string has one way to decode, for calculation convenience)
        int dp_prev2 = 1; 

        // dp[1] depends on s[0]
        // If s[0] is '0', it cannot be decoded, so 0 ways.
        // Otherwise, it can be decoded as a single digit, so 1 way.
        int dp_prev1 = (s[0] == '0' ? 0 : 1);

        // Iterate from the second character (index 1) up to the end of the string
        // i represents the current length of the prefix being considered (s[0...i-1])
        for (int i = 2; i <= n; ++i) {
            int dp_curr = 0;

            // Check for single digit decode (s[i-1])
            // If the current digit is not '0', it can be decoded alone.
            // The number of ways is the same as decoding the prefix s[0...i-2].
            if (s[i-1] != '0') {
                dp_curr += dp_prev1;
            }

            // Check for two digit decode (s[i-2]s[i-1])
            // Form the two-digit number from s[i-2] and s[i-1].
            int two_digit_num = (s[i-2] - '0') * 10 + (s[i-1] - '0');

            // If the two-digit number is between 10 and 26 (inclusive), it can be decoded.
            // The number of ways is the same as decoding the prefix s[0...i-3].
            if (two_digit_num >= 10 && two_digit_num <= 26) {
                dp_curr += dp_prev2;
            }

            // Update dp_prev2 and dp_prev1 for the next iteration
            dp_prev2 = dp_prev1;
            dp_prev1 = dp_curr;
        }

        // dp_prev1 now holds the number of ways to decode the entire string s (dp[n])
        return dp_prev1;
    }
};