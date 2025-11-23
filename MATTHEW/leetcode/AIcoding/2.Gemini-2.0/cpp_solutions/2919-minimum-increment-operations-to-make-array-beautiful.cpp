#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minIncrementOperations(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            if (i < 3) {
                dp[i] = dp[i - 1] + max(0, k - nums[i - 1]);
            } else {
                dp[i] = min({dp[i - 1] + max(0, k - nums[i - 1]),
                              dp[i - 2] + max(0, k - nums[i - 2]),
                              dp[i - 3] + max(0, k - nums[i - 3])});
            }
        }

        return dp[n];
    }
};