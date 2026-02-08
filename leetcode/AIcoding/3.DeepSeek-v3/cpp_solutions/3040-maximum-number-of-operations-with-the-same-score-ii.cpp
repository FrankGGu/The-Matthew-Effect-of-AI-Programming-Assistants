class Solution {
public:
    int maxOperations(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;

        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int len = 2; len <= n; len += 2) {
            for (int i = 0; i + len - 1 < n; ++i) {
                int j = i + len - 1;
                if (len == 2) {
                    dp[i][j] = 1;
                } else {
                    int res = 0;
                    if (nums[i] + nums[i+1] == nums[i] + nums[j]) {
                        res = max(res, (i+2 <= j-1 ? dp[i+2][j-1] : 0) + 1);
                    }
                    if (nums[i] + nums[j] == nums[j-1] + nums[j]) {
                        res = max(res, (i+1 <= j-2 ? dp[i+1][j-2] : 0) + 1);
                    }
                    if (nums[j-1] + nums[j] == nums[i] + nums[j]) {
                        res = max(res, (i+1 <= j-2 ? dp[i+1][j-2] : 0) + 1);
                    }
                    dp[i][j] = res;
                }
            }
        }

        return dp[0][n-1];
    }
};