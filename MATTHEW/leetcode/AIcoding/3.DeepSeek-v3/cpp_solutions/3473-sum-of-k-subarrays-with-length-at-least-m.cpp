class Solution {
public:
    int sumOfKSubarrays(vector<int>& nums, int k, int m) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<int> dp(n + 1, 0);
        deque<int> dq;
        int res = 0;

        for (int i = m; i <= n; ++i) {
            int sum = prefix[i] - prefix[i - m];
            while (!dq.empty() && sum <= prefix[dq.back()] - (dq.back() - m >= 0 ? prefix[dq.back() - m] : 0)) {
                dq.pop_back();
            }
            dq.push_back(i);

            if (i - dq.front() >= k * m) {
                dq.pop_front();
            }

            if (i >= k * m) {
                res = max(res, prefix[i] - prefix[i - k * m]);
                if (!dq.empty()) {
                    int min_sum = prefix[dq.front()] - (dq.front() - m >= 0 ? prefix[dq.front() - m] : 0);
                    res = max(res, prefix[i] - prefix[i - k * m] - min_sum);
                }
            }
        }

        return res;
    }
};