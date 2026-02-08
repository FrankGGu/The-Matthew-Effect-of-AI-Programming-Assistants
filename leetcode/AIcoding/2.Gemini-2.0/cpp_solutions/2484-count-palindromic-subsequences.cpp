#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countPalindromicSubsequences(string s) {
        int n = s.length();
        int MOD = 1000000007;

        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;

                if (s[i] == s[j]) {
                    int low = i + 1;
                    int high = j - 1;

                    while (low <= high && s[low] != s[i]) {
                        low++;
                    }
                    while (low <= high && s[high] != s[i]) {
                        high--;
                    }

                    if (low > high) {
                        dp[i][j] = (2 * dp[i + 1][j - 1] + 2) % MOD;
                    } else if (low == high) {
                        dp[i][j] = (2 * dp[i + 1][j - 1] + 1) % MOD;
                    } else {
                        dp[i][j] = (2 * dp[i + 1][j - 1] - dp[low + 1][high - 1] + MOD) % MOD;
                    }
                } else {
                    dp[i][j] = ((dp[i][j - 1] + dp[i + 1][j] - dp[i + 1][j - 1]) % MOD + MOD) % MOD;
                }
            }
        }

        return dp[0][n - 1];
    }
};