class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            unordered_map<int, int> freq;
            int trim = 0;
            for (int j = i - 1; j >= 0; --j) {
                int num = nums[j];
                freq[num]++;
                if (freq[num] == 2) {
                    trim += 2;
                } else if (freq[num] > 2) {
                    trim += 1;
                }
                if (dp[j] != INT_MAX) {
                    dp[i] = min(dp[i], dp[j] + k + trim);
                }
            }
        }
        return dp[n];
    }
};