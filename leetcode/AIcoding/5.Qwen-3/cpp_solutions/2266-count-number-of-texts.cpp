#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int distinctTexts(string &s) {
        const int MOD = 1e9 + 7;
        int n = s.length();
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            if (s[i - 1] == ' ') {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = dp[i - 1];
                if (i >= 2 && s[i - 2] == s[i - 1]) {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
                if (i >= 3 && s[i - 3] == s[i - 2] && s[i - 2] == s[i - 1]) {
                    dp[i] = (dp[i] + dp[i - 3]) % MOD;
                }
            }
        }

        return dp[n];
    }
};