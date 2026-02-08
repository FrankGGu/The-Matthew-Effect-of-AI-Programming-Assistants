#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int solve(int i, int prev, vector<int>& nums, int d, vector<vector<int>>& dp) {
        if (i == nums.size()) {
            return 0;
        }

        if (dp[i][prev + 1] != -1) {
            return dp[i][prev + 1];
        }

        int notTake = solve(i + 1, prev, nums, d, dp);
        int take = 0;

        if (prev == -1 || (long long)nums[i] * d <= (long long)nums[prev]) {
            take = 1 + solve(i + 1, i, nums, d, dp);
        }

        return dp[i][prev + 1] = max(take, notTake);
    }

    int solveTab(vector<int>& nums, int d) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(n + 2, 0));

        for (int i = n - 1; i >= 0; --i) {
            for (int prev = n; prev >= -1; --prev) {
                int notTake = dp[i + 1][prev + 1];
                int take = 0;

                if (prev == -1 || (long long)nums[i] * d <= (long long)nums[prev]) {
                    take = 1 + dp[i + 1][i + 1];
                }

                dp[i][prev + 1] = max(take, notTake);
            }
        }
        return dp[0][0];
    }

    int solveSpaceOpt(vector<int>& nums, int d) {
        int n = nums.size();
        vector<int> curr(n + 2, 0);
        vector<int> next(n + 2, 0);

        for (int i = n - 1; i >= 0; --i) {
            for (int prev = n; prev >= -1; --prev) {
                int notTake = next[prev + 1];
                int take = 0;

                if (prev == -1 || (long long)nums[i] * d <= (long long)nums[prev]) {
                    take = 1 + next[i + 1];
                }

                curr[prev + 1] = max(take, notTake);
            }
            next = curr;
        }
        return next[0];
    }

    int maxValidSubsequenceSize(vector<int>& nums, int d) {
        int n = nums.size();
        vector<vector<int>> dp(n, vector<int>(n + 1, -1));
        return solveSpaceOpt(nums, d);
    }
};