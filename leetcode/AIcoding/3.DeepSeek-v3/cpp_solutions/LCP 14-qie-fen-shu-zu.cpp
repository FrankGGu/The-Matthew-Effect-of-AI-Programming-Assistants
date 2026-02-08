class Solution {
public:
    int splitArray(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, INT_MAX);
        unordered_map<int, int> last;
        dp[0] = 1;
        last[nums[0]] = 0;
        for (int i = 1; i < n; ++i) {
            dp[i] = dp[i-1] + 1;
            if (last.count(nums[i])) {
                int prev = last[nums[i]];
                dp[i] = min(dp[i], (prev == 0 ? 1 : dp[prev-1]) + 1);
            }
            last[nums[i]] = i;
        }
        return dp[n-1];
    }
};