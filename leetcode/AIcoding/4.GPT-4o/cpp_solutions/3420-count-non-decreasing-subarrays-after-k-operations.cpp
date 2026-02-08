class Solution {
public:
    long long countNonDecreasing(vector<int>& nums, int k) {
        int n = nums.size();
        long long count = 0;
        vector<int> dp(n, 1);

        for (int i = 1; i < n; ++i) {
            if (nums[i] >= nums[i - 1]) {
                dp[i] = dp[i - 1] + 1;
            }
        }

        for (int i = 0; i < n; ++i) {
            count += dp[i];
        }

        for (int i = 0; i < n; ++i) {
            int j = i;
            while (j < n - 1 && nums[j] <= nums[j + 1]) {
                ++j;
            }
            int len = j - i + 1;
            if (len > 1) {
                long long total = (len * (len - 1)) / 2;
                count -= total;
            }
            int left_ops = min(k, i + 1);
            int right_ops = min(k, n - j);
            count += (long long)(left_ops + right_ops) * (len);
        }

        return count;
    }
};