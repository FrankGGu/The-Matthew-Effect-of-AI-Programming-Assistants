#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSidewaysJumps(int n, vector<vector<int>>& obstacles) {
        vector<vector<int>> dp(n, vector<int>(3, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (i == 0) {
                    dp[i][j] = j;
                } else {
                    dp[i][j] = dp[i - 1][j];
                    if (obstacles[i][j] == 1) {
                        dp[i][j] = INT_MAX;
                    } else {
                        for (int k = 0; k < 3; ++k) {
                            if (k != j && obstacles[i][k] != 1) {
                                dp[i][j] = min(dp[i][j], dp[i - 1][k] + 1);
                            }
                        }
                    }
                }
            }
        }
        return *min_element(dp[n - 1].begin(), dp[n - 1].end());
    }

    int minSidewaysJumps(vector<vector<int>>& obstacles) {
        int n = obstacles.size();
        vector<vector<int>> dp(n, vector<int>(3, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (i == 0) {
                    dp[i][j] = j;
                } else {
                    dp[i][j] = dp[i - 1][j];
                    if (obstacles[i][j] == 1) {
                        dp[i][j] = INT_MAX;
                    } else {
                        for (int k = 0; k < 3; ++k) {
                            if (k != j && obstacles[i][k] != 1) {
                                dp[i][j] = min(dp[i][j], dp[i - 1][k] + 1);
                            }
                        }
                    }
                }
            }
        }
        return *min_element(dp[n - 1].begin(), dp[n - 1].end());
    }
};