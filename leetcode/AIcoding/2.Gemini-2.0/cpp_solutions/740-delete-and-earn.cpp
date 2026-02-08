#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int deleteAndEarn(vector<int>& nums) {
        if (nums.empty()) return 0;

        int maxVal = *max_element(nums.begin(), nums.end());
        vector<int> sums(maxVal + 1, 0);
        for (int num : nums) {
            sums[num] += num;
        }

        vector<int> dp(maxVal + 1, 0);
        dp[0] = 0;
        dp[1] = sums[1];

        for (int i = 2; i <= maxVal; ++i) {
            dp[i] = max(dp[i - 1], dp[i - 2] + sums[i]);
        }

        return dp[maxVal];
    }
};