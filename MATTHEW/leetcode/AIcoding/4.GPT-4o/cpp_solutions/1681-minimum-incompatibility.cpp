class Solution {
public:
    int minimumIncompatibility(vector<int>& nums, int k) {
        int n = nums.size();
        int maxMask = 1 << n;
        vector<int> dp(maxMask, INT_MAX);
        vector<int> groupMask(k, 0);
        dp[0] = 0;

        for (int mask = 0; mask < maxMask; ++mask) {
            int groupSize = __builtin_popcount(mask);
            if (groupSize % (n / k) != 0) continue;
            int groupIndex = groupSize / (n / k);
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) continue;
                int newMask = mask | (1 << i);
                if (groupMask[groupIndex] & (1 << nums[i])) continue;
                groupMask[groupIndex] |= (1 << nums[i]);
                dp[newMask] = min(dp[newMask], dp[mask] + (groupSize == 0 ? 0 : (groupMask[groupIndex] ^ (1 << nums[i])))));
                groupMask[groupIndex] ^= (1 << nums[i]);
            }
        }

        return dp[maxMask - 1] == INT_MAX ? -1 : dp[maxMask - 1];
    }
};