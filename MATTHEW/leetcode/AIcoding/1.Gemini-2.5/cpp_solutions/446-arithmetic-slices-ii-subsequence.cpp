#include <vector>
#include <unordered_map>

class Solution {
public:
    int numberOfArithmeticSlices(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 3) {
            return 0;
        }

        int ans = 0;
        std::vector<std::unordered_map<long long, int>> dp(n);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                long long diff = (long long)nums[i] - nums[j];

                int count = 0;
                if (dp[j].count(diff)) {
                    count = dp[j][diff];
                }

                ans += count;
                dp[i][diff] += count + 1;
            }
        }

        return ans;
    }
};