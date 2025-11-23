#include <vector>

using namespace std;

class Solution {
public:
    int numberOfWays(string num) {
        int n = num.size();
        if (n == 0) return 0;

        const int MOD = 1e9 + 7;

        vector<vector<int>> lcp(n + 1, vector<int>(n + 1, 0));
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (num[i] == num[j]) {
                    lcp[i][j] = lcp[i + 1][j + 1] + 1;
                }
            }
        }

        vector<vector<int>> dp(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            if (num[0] != '0') {
                dp[0][i] = 1;
            }
        }

        for (int i = 1; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                if (num[i] == '0') {
                    dp[i][j] = 0;
                    continue;
                }

                for (int k = i - 1; k >= 0; --k) {
                    int len1 = i - k;
                    int len2 = j - i + 1;

                    if (len1 > len2) {
                        dp[i][j] = (dp[i][j] + dp[k][i - 1]) % MOD;
                    } else {
                        int common = lcp[k + 1][i];
                        if (common < len1 && num[k + 1 + common] < num[i + common]) {
                            dp[i][j] = (dp[i][j] + dp[k][i - 1]) % MOD;
                        } else if (common == len1 && len1 <= len2) {
                             dp[i][j] = (dp[i][j] + dp[k][i - 1]) % MOD;
                        }
                    }
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < n; ++i) {
            ans = (ans + dp[i][n - 1]) % MOD;
        }

        return ans;
    }
};