#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countMonotonicPairs(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                if (nums[i] <= nums[j]) {
                    dp[i][j] = dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1];
                } else {
                    dp[i][j] = dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1];
                }
            }
        }

        return dp[0][n-1];
    }
};