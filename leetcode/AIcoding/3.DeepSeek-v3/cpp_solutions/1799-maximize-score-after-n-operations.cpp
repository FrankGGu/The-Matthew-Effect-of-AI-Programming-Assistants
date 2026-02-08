class Solution {
public:
    int maxScore(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(1 << n, 0);
        for (int mask = 0; mask < (1 << n); ++mask) {
            int cnt = __builtin_popcount(mask);
            if (cnt % 2 != 0) continue;
            int k = cnt / 2 + 1;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) continue;
                for (int j = i + 1; j < n; ++j) {
                    if (mask & (1 << j)) continue;
                    int new_mask = mask | (1 << i) | (1 << j);
                    dp[new_mask] = max(dp[new_mask], dp[mask] + k * __gcd(nums[i], nums[j]));
                }
            }
        }
        return dp[(1 << n) - 1];
    }
};