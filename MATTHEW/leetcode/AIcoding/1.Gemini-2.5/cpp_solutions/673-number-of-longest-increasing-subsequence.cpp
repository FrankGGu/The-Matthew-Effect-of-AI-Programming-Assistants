#include <vector>
#include <algorithm>

class Solution {
public:
    int findNumberOfLIS(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        std::vector<int> dp(n, 1);    // dp[i] stores the length of the LIS ending at index i
        std::vector<int> count(n, 1); // count[i] stores the number of LIS with length dp[i] ending at index i

        int maxLength = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j]) {
                    if (dp[j] + 1 > dp[i]) {
                        dp[i] = dp[j] + 1;
                        count[i] = count[j];
                    } else if (dp[j] + 1 == dp[i]) {
                        count[i] += count[j];
                    }
                }
            }
            maxLength = std::max(maxLength, dp[i]);
        }

        int totalCount = 0;
        for (int i = 0; i < n; ++i) {
            if (dp[i] == maxLength) {
                totalCount += count[i];
            }
        }

        return totalCount;
    }
};