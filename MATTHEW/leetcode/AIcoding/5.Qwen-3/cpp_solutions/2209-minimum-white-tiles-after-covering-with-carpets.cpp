#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumWhiteTiles(int n, int m, vector<int>& s, vector<int>& k) {
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (s[i - 1] <= j) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - s[i - 1]] + 1);
                }
            }
        }
        int covered = dp[n][m];
        int total_white = 0;
        for (int i = 0; i < n; ++i) {
            total_white += 1;
        }
        return total_white - covered;
    }
};