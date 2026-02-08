#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;

class Solution {
public:
    int findTargetSumWays(vector<int>& nums, int target) {
        int total = 0;
        for (int num : nums) {
            total += num;
        }

        if (abs(target) > total) {
            return 0;
        }

        int sum = total + target;
        if (sum % 2 != 0) {
            return 0;
        }

        int bag = sum / 2;
        vector<int> dp(bag + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = bag; j >= num; j--) {
                dp[j] += dp[j - num];
            }
        }

        return dp[bag];
    }
};