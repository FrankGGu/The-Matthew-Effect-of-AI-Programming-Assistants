#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int burstBalloon(vector<int>& nums, int left, int right, vector<vector<int>>& dp) {
        if (left > right) return 0;
        if (dp[left][right] != 0) return dp[left][right];

        int maxCoins = 0;
        for (int i = left; i <= right; ++i) {
            int coins = nums[left - 1] * nums[i] * nums[right + 1];
            coins += burstBalloon(nums, left, i - 1, dp) + burstBalloon(nums, i + 1, right, dp);
            maxCoins = max(maxCoins, coins);
        }

        dp[left][right] = maxCoins;
        return maxCoins;
    }

    int burstBalloons(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> dp(n + 2, vector<int>(n + 2, 0));
        return burstBalloon(nums, 1, n, dp);
    }
};