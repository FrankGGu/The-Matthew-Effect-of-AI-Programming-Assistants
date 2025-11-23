#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int stoneGameV(string s) {
        int n = s.length();
        vector<vector<int>> dp(n, vector<int>(n, 0));
        vector<int> prefix(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (s[i] == 'S' ? 1 : 0);
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                int sum = prefix[j + 1] - prefix[i];
                int left = 0, right = 0;
                for (int k = i; k < j; ++k) {
                    if (s[k] == 'S') {
                        left = prefix[k + 1] - prefix[i];
                        right = sum - left;
                        dp[i][j] = max(dp[i][j], dp[i][k] + dp[k + 1][j] + min(left, right));
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
};