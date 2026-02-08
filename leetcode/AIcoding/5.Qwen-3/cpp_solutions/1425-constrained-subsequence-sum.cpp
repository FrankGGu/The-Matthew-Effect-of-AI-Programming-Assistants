#include <iostream>
#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    int constrainedSubsetSum(int n, int k, vector<int>& nums) {
        vector<int> dp(n, 0);
        deque<int> q;

        for (int i = 0; i < n; ++i) {
            int prev = (q.empty() ? 0 : dp[q.front()]);
            dp[i] = max(prev + nums[i], nums[i]);

            while (!q.empty() && dp[i] >= dp[q.back()]) {
                q.pop_back();
            }

            q.push_back(i);

            if (q.front() == i - k) {
                q.pop_front();
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};