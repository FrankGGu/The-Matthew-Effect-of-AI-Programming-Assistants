#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDifference(vector<int>& nums) {
        int n = nums.size();
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        vector<vector<bool>> dp(n + 1, vector<bool>(totalSum + 1, false));
        dp[0][0] = true;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j <= totalSum; ++j) {
                if (dp[i][j]) {
                    dp[i + 1][j + nums[i]] = true;
                    dp[i + 1][j] = true;
                }
            }
        }

        int minDiff = INT_MAX;
        for (int j = 0; j <= totalSum; ++j) {
            if (dp[n][j]) {
                int diff = abs((totalSum - j) - j);
                minDiff = min(minDiff, diff);
            }
        }

        return minDiff;
    }
};