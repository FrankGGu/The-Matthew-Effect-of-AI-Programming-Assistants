#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumScore(vector<int>& nums, vector<int>& multipliers) {
        int n = nums.size();
        int m = multipliers.size();
        vector<vector<int>> dp(m + 1, vector<int>(m + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 0; j <= i; ++j) {
                int k = i - j;
                if (k > n) continue;
                if (j == 0) {
                    dp[i][j] = dp[i-1][j] + (long long)nums[k-1] * multipliers[i-1];
                } else if (k == 0) {
                    dp[i][j] = dp[i-1][j-1] + (long long)nums[j-1] * multipliers[i-1];
                } else {
                    dp[i][j] = max(dp[i-1][j-1] + (long long)nums[j-1] * multipliers[i-1], 
                                   dp[i-1][j] + (long long)nums[n - k] * multipliers[i-1]);
                }
            }
        }

        int maxScore = 0;
        for (int j = 0; j <= m; ++j) {
            maxScore = max(maxScore, dp[m][j]);
        }
        return maxScore;
    }
};