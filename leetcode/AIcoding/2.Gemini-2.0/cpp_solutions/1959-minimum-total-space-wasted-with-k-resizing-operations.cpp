#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minSpaceWastedKResizing(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 2, INT_MAX));
        vector<vector<int>> wasted(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            int maxVal = 0;
            int sum = 0;
            for (int j = i; j < n; ++j) {
                maxVal = max(maxVal, nums[j]);
                sum += nums[j];
                wasted[i][j] = maxVal * (j - i + 1) - sum;
            }
        }

        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k + 1; ++j) {
                for (int x = 1; x <= i; ++x) {
                    if (dp[i - x][j - 1] != INT_MAX) {
                        dp[i][j] = min(dp[i][j], dp[i - x][j - 1] + wasted[i - x][i - 1]);
                    }
                }
            }
        }

        return dp[n][k + 1];
    }
};