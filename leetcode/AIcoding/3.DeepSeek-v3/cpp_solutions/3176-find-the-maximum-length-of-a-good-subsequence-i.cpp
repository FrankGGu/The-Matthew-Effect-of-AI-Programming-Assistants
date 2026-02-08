class Solution {
public:
    int maximumLength(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(n, vector<int>(k + 1, 1));
        vector<vector<int>> max_len(k + 1, vector<int>(2, 0));
        vector<int> global_max(k + 1, 1);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j <= k; ++j) {
                if (j > 0) {
                    dp[i][j] = max(dp[i][j], global_max[j - 1] + 1);
                }
                if (max_len[j][0] != nums[i]) {
                    dp[i][j] = max(dp[i][j], max_len[j][1] + 1);
                } else {
                    if (j > 0) {
                        dp[i][j] = max(dp[i][j], max_len[j - 1][1] + 1);
                    }
                }
                global_max[j] = max(global_max[j], dp[i][j]);
            }

            for (int j = 0; j <= k; ++j) {
                if (dp[i][j] > max_len[j][1]) {
                    if (max_len[j][0] != nums[i]) {
                        max_len[j][0] = nums[i];
                        max_len[j][1] = dp[i][j];
                    } else {
                        max_len[j][1] = dp[i][j];
                    }
                }
            }
        }

        return *max_element(global_max.begin(), global_max.end());
    }
};