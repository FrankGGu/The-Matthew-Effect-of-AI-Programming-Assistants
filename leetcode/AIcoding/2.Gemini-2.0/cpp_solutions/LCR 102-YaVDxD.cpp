#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int findTargetSumWays(vector<int>& nums, int target) {
        int sum = accumulate(nums.begin(), nums.end(), 0);
        if (abs(target) > sum) {
            return 0;
        }
        if ((sum + target) % 2 != 0) {
            return 0;
        }
        int positiveSum = (sum + target) / 2;
        vector<int> dp(positiveSum + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int i = positiveSum; i >= num; i--) {
                dp[i] += dp[i - num];
            }
        }

        return dp[positiveSum];
    }
};