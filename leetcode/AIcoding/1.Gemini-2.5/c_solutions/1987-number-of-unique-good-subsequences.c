#include <string.h>

int numberOfUniqueGoodSubsequences(char * s){
    long long MOD = 1e9 + 7;

    // good_dp[0]: count of unique subsequences starting with '1' and ending with '0'
    // good_dp[1]: count of unique subsequences starting with '1' and ending with '1'
    long long good_dp[2] = {0, 0};

    int n = strlen(s);
    for (int i = 0; i < n; ++i) {
        char c = s[i];
        if (c == '0') {
            // When '0' is encountered:
            // New good subsequences ending with '0' can be formed by appending '0' to:
            // 1. Existing good subsequences ending with '0' (good_dp[0])
            // 2. Existing good subsequences ending with '1' (good_dp[1])
            // The single character '0' itself is not a good subsequence as it doesn't start with '1'.
            good_dp[0] = (good_dp[0] + good_dp[1]) % MOD;
        } else { // c == '1'
            // When '1' is encountered:
            // New good subsequences ending with '1' can be formed by appending '1' to:
            // 1. Existing good subsequences ending with '0' (good_dp[0])
            // 2. Existing good subsequences ending with '1' (good_dp[1])
            // 3. The single character '1' itself (which is a good subsequence).
            good_dp[1] = (good_dp[0] + good_dp[1] + 1) % MOD;
        }
    }

    // The result is the number of unique good subsequences ending with '1'.
    // This is `good_dp[1]`.
    return (int)good_dp[1];
}