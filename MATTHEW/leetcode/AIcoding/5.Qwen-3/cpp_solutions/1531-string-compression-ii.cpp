#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getLengthOfOptimalCompression(string& s, int k) {
        int n = s.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                dp[i][j] = dp[i - 1][j] + 1;
                if (j > 0) {
                    dp[i][j] = min(dp[i][j], dp[i - 1][j - 1]);
                }
                for (int p = i - 1; p > 0 && j - (i - p) >= 0; --p) {
                    if (s[p] == s[i]) {
                        int cost = 0;
                        if (i - p == 1) cost = 1;
                        else if (i - p == 2) cost = 2;
                        else if (i - p == 3) cost = 3;
                        else cost = 4;
                        dp[i][j] = min(dp[i][j], dp[p - 1][j - (i - p)] + cost);
                    }
                }
            }
        }

        return dp[n][k];
    }
};