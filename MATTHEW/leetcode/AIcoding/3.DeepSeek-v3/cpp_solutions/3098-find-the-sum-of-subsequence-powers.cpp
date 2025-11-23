#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int sumOfPowers(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(k + 1, vector<int>(n + 1, -1)));
        return dfs(nums, 0, k, n, dp);
    }

private:
    int dfs(vector<int>& nums, int index, int k, int last, vector<vector<vector<int>>>& dp) {
        if (k == 0) {
            return 0;
        }
        if (index >= nums.size()) {
            return INT_MAX;
        }
        if (dp[index][k][last] != -1) {
            return dp[index][k][last];
        }

        int take = INT_MAX;
        if (last == nums.size()) {
            take = dfs(nums, index + 1, k - 1, index, dp);
        } else {
            int diff = nums[index] - nums[last];
            int next = dfs(nums, index + 1, k - 1, index, dp);
            if (next != INT_MAX) {
                take = min(diff, next);
            }
        }

        int notTake = dfs(nums, index + 1, k, last, dp);

        int result;
        if (take == INT_MAX && notTake == INT_MAX) {
            result = INT_MAX;
        } else if (take == INT_MAX) {
            result = notTake;
        } else if (notTake == INT_MAX) {
            result = take;
        } else {
            result = take + notTake;
        }

        dp[index][k][last] = result;
        return result;
    }
};