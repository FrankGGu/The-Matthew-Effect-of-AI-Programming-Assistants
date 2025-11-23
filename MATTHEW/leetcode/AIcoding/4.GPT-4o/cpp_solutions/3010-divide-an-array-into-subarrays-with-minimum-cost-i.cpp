class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            unordered_map<int, int> count;
            int uniqueCount = 0;

            for (int j = i; j > 0; --j) {
                if (count[nums[j - 1]]++ == 0) uniqueCount++;
                dp[i] = min(dp[i], dp[j - 1] + uniqueCount + k - 1);
            }
        }

        return dp[n];
    }
};