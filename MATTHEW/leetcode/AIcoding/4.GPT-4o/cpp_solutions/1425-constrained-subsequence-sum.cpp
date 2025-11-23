#include <vector>
#include <deque>
#include <algorithm>

class Solution {
public:
    int constrainedSubsetSum(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<int> dp(n);
        std::deque<int> dq;
        int maxSum = nums[0];

        for (int i = 0; i < n; ++i) {
            dp[i] = nums[i];
            if (!dq.empty()) {
                dp[i] = std::max(dp[i], nums[i] + dq.front());
            }
            while (!dq.empty() && dp[i] > dq.back()) {
                dq.pop_back();
            }
            dq.push_back(dp[i]);
            if (i >= k) {
                if (dq.front() == dp[i - k]) {
                    dq.pop_front();
                }
            }
            maxSum = std::max(maxSum, dp[i]);
        }

        return maxSum;
    }
};