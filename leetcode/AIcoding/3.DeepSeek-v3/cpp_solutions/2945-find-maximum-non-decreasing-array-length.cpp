class Solution {
public:
    int findMaximumLength(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n + 1, 0);
        vector<long long> prefix(n + 1, 0);
        vector<int> last(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            prefix[i] = prefix[i - 1] + nums[i - 1];
        }

        vector<long long> sum(n + 2, 0);
        vector<int> indices(n + 2, 0);
        int left = 0, right = 0;

        for (int i = 1; i <= n; ++i) {
            while (left < right && sum[left + 1] <= prefix[i]) {
                left++;
            }
            int j = indices[left];
            dp[i] = dp[j] + 1;
            long long curr_sum = prefix[i] * 2 - prefix[j];
            while (right >= left && sum[right] >= curr_sum) {
                right--;
            }
            sum[++right] = curr_sum;
            indices[right] = i;
        }

        return dp[n];
    }
};