#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    int constrainedSubsetSum(vector<int>& nums, int k) {
        int n = nums.size();
        deque<int> dq;
        vector<int> dp(n);
        int maxSum = nums[0];

        for (int i = 0; i < n; ++i) {
            if (!dq.empty()) {
                dp[i] = max(nums[i], nums[i] + dp[dq.front()]);
            } else {
                dp[i] = nums[i];
            }

            maxSum = max(maxSum, dp[i]);

            while (!dq.empty() && dp[dq.back()] <= dp[i]) {
                dq.pop_back();
            }

            dq.push_back(i);

            if (dq.front() == i - k) {
                dq.pop_front();
            }
        }

        return maxSum;
    }
};