class Solution {
public:
    int maximumANDSum(vector<int>& nums, int numSlots) {
        int n = nums.size();
        vector<int> dp(1 << (2 * numSlots), 0);
        int res = 0;

        for (int mask = 0; mask < (1 << (2 * numSlots)); ++mask) {
            int cnt = __builtin_popcount(mask);
            if (cnt >= n) continue;
            for (int i = 0; i < 2 * numSlots; ++i) {
                if (!(mask & (1 << i))) {
                    int new_mask = mask | (1 << i);
                    int slot = i / 2 + 1;
                    dp[new_mask] = max(dp[new_mask], dp[mask] + (nums[cnt] & slot));
                    res = max(res, dp[new_mask]);
                }
            }
        }
        return res;
    }
};