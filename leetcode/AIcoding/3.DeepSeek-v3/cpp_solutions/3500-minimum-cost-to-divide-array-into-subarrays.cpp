class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            unordered_map<int, int> freq;
            int unique = 0;
            for (int j = i - 1; j >= 0; --j) {
                int num = nums[j];
                freq[num]++;
                if (freq[num] == 1) {
                    unique++;
                } else if (freq[num] == 2) {
                    unique--;
                }
                int cost = k + (i - j) - unique;
                if (dp[j] != INT_MAX) {
                    dp[i] = min(dp[i], dp[j] + cost);
                }
            }
        }
        return dp[n];
    }
};