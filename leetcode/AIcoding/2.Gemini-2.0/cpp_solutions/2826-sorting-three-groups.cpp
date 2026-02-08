#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(4, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= 3; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (nums[i - 1] != j) {
                    dp[i][j]++;
                }
            }
            for (int j = 2; j <= 3; ++j) {
                dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + (nums[i - 1] != j ? 1 : 0));
            }
        }

        return dp[n][3];
    }
};