#include <vector>
#include <numeric>
#include <algorithm>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int target) {
        int n = nums.size();
        vector<int> dp(target + 1, INT_MAX);
        dp[0] = 0;

        for (int num : nums) {
            for (int j = target; j >= num; --j) {
                if (dp[j - num] != INT_MAX) {
                    dp[j] = min(dp[j], dp[j - num] + 1);
                }
            }
        }

        return dp[target] == INT_MAX ? -1 : dp[target];
    }
};