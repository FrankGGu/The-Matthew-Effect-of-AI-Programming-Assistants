class Solution {
public:
    int numberOfUniqueGoodSubsequences(string binary) {
        const int MOD = 1e9 + 7;
        int dp0 = 0, dp1 = 0, has0 = 0;
        for (char c : binary) {
            if (c == '0') {
                dp0 = (dp0 + dp1 + 1) % MOD;
                has0 = 1;
            } else {
                dp1 = (dp0 + dp1 + 1) % MOD;
            }
        }
        return (dp0 + dp1 + has0) % MOD;
    }
};