class Solution {
public:
    int maximumANDSum(vector<int>& nums, int numSlots) {
        int n = nums.size();
        int maxMask = (1 << (2 * numSlots)) - 1;
        vector<int> dp(maxMask + 1, 0);

        for (int mask = 0; mask <= maxMask; ++mask) {
            int count = __builtin_popcount(mask);
            if (count > n) continue;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << (2 * nums[i] - 1))) continue;
                if (mask & (1 << (2 * nums[i]))) continue;
                int nextMask = mask | (1 << (2 * nums[i] - 1)) | (1 << (2 * nums[i]));
                dp[nextMask] = max(dp[nextMask], dp[mask] + nums[i]);
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};