class Solution {
public:
    vector<int> maxSumOfThreeSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> sum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            sum[i + 1] = sum[i] + nums[i];
        }

        vector<int> left(n, 0);
        int max_sum = 0;
        for (int i = k - 1; i < n; ++i) {
            int current = sum[i + 1] - sum[i + 1 - k];
            if (current > max_sum) {
                max_sum = current;
                left[i] = i - k + 1;
            } else {
                left[i] = left[i - 1];
            }
        }

        vector<int> right(n, 0);
        max_sum = 0;
        for (int i = n - k; i >= 0; --i) {
            int current = sum[i + k] - sum[i];
            if (current >= max_sum) {
                max_sum = current;
                right[i] = i;
            } else {
                right[i] = right[i + 1];
            }
        }

        vector<int> res(3, 0);
        max_sum = 0;
        for (int i = k; i <= n - 2 * k; ++i) {
            int l = left[i - 1];
            int r = right[i + k];
            int total = (sum[l + k] - sum[l]) + (sum[i + k] - sum[i]) + (sum[r + k] - sum[r]);
            if (total > max_sum) {
                max_sum = total;
                res = {l, i, r};
            }
        }

        return res;
    }
};