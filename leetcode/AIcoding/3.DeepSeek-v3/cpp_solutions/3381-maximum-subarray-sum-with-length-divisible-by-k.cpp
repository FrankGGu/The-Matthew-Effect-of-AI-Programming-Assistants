class Solution {
public:
    int maxSubarraySumCircular(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> prefix(2 * n + 1, 0);
        for (int i = 0; i < 2 * n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i % n];
        }

        deque<int> dq;
        int res = INT_MIN;
        for (int i = 0; i <= 2 * n; ++i) {
            while (!dq.empty() && i - dq.front() > k) {
                dq.pop_front();
            }
            if (!dq.empty()) {
                res = max(res, prefix[i] - prefix[dq.front()]);
            }
            while (!dq.empty() && prefix[i] <= prefix[dq.back()]) {
                dq.pop_back();
            }
            dq.push_back(i);
        }
        return res;
    }
};