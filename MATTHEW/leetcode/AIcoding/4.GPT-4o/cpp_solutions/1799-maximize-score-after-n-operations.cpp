class Solution {
public:
    int maxScore(vector<int>& nums) {
        int n = nums.size();
        int maxMask = (1 << n) - 1;
        vector<int> dp(maxMask + 1, 0);

        for (int mask = 0; mask <= maxMask; ++mask) {
            int count = __builtin_popcount(mask);
            if (count % 2 == 1) continue;
            int operation = count / 2 + 1;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) continue;
                for (int j = i + 1; j < n; ++j) {
                    if (mask & (1 << j)) continue;
                    int newMask = mask | (1 << i) | (1 << j);
                    dp[newMask] = max(dp[newMask], operation * gcd(nums[i], nums[j]) + dp[mask]);
                }
            }
        }
        return dp[maxMask];
    }
};