class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, INT_MAX));
        vector<int> count(n + 1, 0);

        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                unordered_map<int, int> freq;
                int cost = 0;
                for (int l = i; l > 0; --l) {
                    freq[nums[l - 1]]++;
                    cost = (freq[nums[l - 1]] == 1) ? cost + 1 : cost;
                    dp[i][j] = min(dp[i][j], dp[l - 1][j - 1] + cost);
                }
            }
        }

        return dp[n][k];
    }
};