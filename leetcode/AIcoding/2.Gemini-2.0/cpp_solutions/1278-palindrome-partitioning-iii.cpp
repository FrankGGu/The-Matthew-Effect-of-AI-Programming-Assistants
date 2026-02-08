#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int palindromePartition(string s, int k) {
        int n = s.length();
        vector<vector<int>> cost(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int l = i, r = j;
                while (l < r) {
                    if (s[l] != s[r]) {
                        cost[i][j]++;
                    }
                    l++;
                    r--;
                }
            }
        }

        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 1e9));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                for (int l = 1; l <= i; ++l) {
                    dp[i][j] = min(dp[i][j], dp[i - l][j - 1] + cost[i - l][i - 1]);
                }
            }
        }

        return dp[n][k];
    }
};