#include <string.h>

int numDecodings(char* s) {
    int n = strlen(s);

    if (n == 0) {
        return 0;
    }

    // dp[i] represents the number of ways to decode s[0...i-1]
    // We use space optimization:
    // prev2 corresponds to dp[i-2]
    // prev1 corresponds to dp[i-1]
    // curr corresponds to dp[i]

    long long prev2 = 1; // Corresponds to dp[0] (empty string, 1 way for calculation)
    long long prev1;     // Corresponds to dp[1]

    if (s[0] == '0') {
        prev1 = 0;
    } else {
        prev1 = 1;
    }

    for (int i = 2; i <= n; i++) {
        long long curr = 0;

        // Check for single digit decoding using s[i-1]
        // If s[i-1] is not '0', it can be decoded independently.
        if (s[i-1] != '0') {
            curr += prev1;
        }

        // Check for two digit decoding using s[i-2]s[i-1]
        // A two-digit number cannot start with '0'.
        // The number formed must be between 10 and 26 (inclusive).
        if (s[i-2] != '0') {
            int two_digit_num = (s[i-2] - '0') * 10 + (s[i-1] - '0');
            if (two_digit_num >= 10 && two_digit_num <= 26) {
                curr += prev2;
            }
        }

        // Update prev2 and prev1 for the next iteration
        prev2 = prev1;
        prev1 = curr;
    }

    return (int)prev1;
}