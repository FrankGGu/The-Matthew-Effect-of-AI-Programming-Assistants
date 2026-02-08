#include <vector>

using namespace std;

class Solution {
public:
    int numPermsDISequence(string s) {
        int n = s.length();
        int mod = 1e9 + 7;

        vector<vector<int>> dp(n + 1, vector<int>(n + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= i; ++j) {
                if (s[i - 1] == 'D') {
                    for (int k = j; k < i; ++k) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % mod;
                    }
                } else {
                    for (int k = 0; k < j; ++k) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % mod;
                    }
                }
            }
        }

        int ans = 0;
        for (int j = 0; j <= n; ++j) {
            ans = (ans + dp[n][j]) % mod;
        }

        return ans;
    }
};