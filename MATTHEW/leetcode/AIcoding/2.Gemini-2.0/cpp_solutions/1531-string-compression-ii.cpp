#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getLengthOfOptimalCompression(string s, int k) {
        int n = s.length();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 1e9));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                if (j > 0) {
                    dp[i][j] = min(dp[i][j], dp[i - 1][j - 1]);
                }
                int del = 0, cnt = 0;
                for (int l = i; l >= 1; --l) {
                    if (s[l - 1] == s[i - 1]) {
                        cnt++;
                    } else {
                        del++;
                    }
                    if (j + del <= k) {
                        int len = (cnt == 1) ? 1 : ((cnt < 10) ? 2 : ((cnt < 100) ? 3 : 4));
                        dp[i][j] = min(dp[i][j], dp[l - 1][j + del] + (cnt == 1 ? 1 : (cnt < 10 ? 2 : (cnt < 100 ? 3 : 4))));
                    }
                }
            }
        }

        int ans = 1e9;
        for (int j = 0; j <= k; ++j) {
            ans = min(ans, dp[n][j]);
        }

        return ans;
    }
};