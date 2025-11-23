class Solution {
public:
    int minChanges(vector<int>& nums, int k) {
        const int n = nums.size();
        const int max_num = 1024;
        vector<vector<int>> freq(k, vector<int>(max_num, 0));
        vector<vector<int>> dp(k, vector<int>(max_num, n + 1));

        for (int i = 0; i < n; ++i) {
            freq[i % k][nums[i]]++;
        }

        int prev_min = 0;
        for (int i = 0; i < k; ++i) {
            int total = (n - i + k - 1) / k;
            int curr_min = n + 1;
            for (int x = 0; x < max_num; ++x) {
                if (i == 0) {
                    dp[i][x] = total - freq[i][x];
                } else {
                    dp[i][x] = prev_min + total;
                    for (int j = i; j < n; j += k) {
                        int y = x ^ nums[j];
                        dp[i][x] = min(dp[i][x], dp[i - 1][y] + total - freq[i][nums[j]]);
                    }
                }
                curr_min = min(curr_min, dp[i][x]);
            }
            prev_min = curr_min;
        }

        return dp[k - 1][0];
    }
};