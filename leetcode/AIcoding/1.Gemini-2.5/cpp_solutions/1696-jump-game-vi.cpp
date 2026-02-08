#include <vector>
#include <deque>
#include <algorithm>

class Solution {
public:
    int maxResult(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<int> dp(n);
        std::deque<int> dq;

        dp[0] = nums[0];
        dq.push_back(0);

        for (int i = 1; i < n; ++i) {
            if (dq.front() < i - k) {
                dq.pop_front();
            }

            dp[i] = nums[i] + dp[dq.front()];

            while (!dq.empty() && dp[dq.back()] <= dp[i]) {
                dq.pop_back();
            }

            dq.push_back(i);
        }

        return dp[n - 1];
    }
};