#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMaximumLength(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefix_sum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        vector<int> dp(n, 0);
        dp[0] = 1;

        for (int i = 1; i < n; ++i) {
            dp[i] = dp[i - 1];
            for (int j = 0; j < i; ++j) {
                if (prefix_sum[i + 1] - prefix_sum[j + 1] >= nums[j + 1]) {
                    if (j == 0) {
                        dp[i] = max(dp[i], 1);
                    } else {
                        dp[i] = max(dp[i], dp[j - 1] + 1);
                    }
                }
            }
            if (prefix_sum[i + 1] - prefix_sum[0] >= nums[0]) {
                dp[i] = max(dp[i], 1);
            }
        }

        return dp[n - 1];
    }
};