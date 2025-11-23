#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumChanges(string s, int k) {
        int n = s.length();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                dp[i][j] = INT_MAX;
                for (int m = j - 1; m < i; ++m) {
                    if (dp[m][j - 1] != INT_MAX) {
                        int cost = 0;
                        int l = m, r = i - 1;
                        while (l < r) {
                            if (s[l] != s[r]) ++cost;
                            ++l; --r;
                        }
                        dp[i][j] = min(dp[i][j], dp[m][j - 1] + cost);
                    }
                }
            }
        }

        return dp[n][k];
    }
};