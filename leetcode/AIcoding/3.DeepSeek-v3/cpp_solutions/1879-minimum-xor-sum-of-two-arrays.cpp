class Solution {
public:
    int minimumXORSum(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int k = __builtin_popcount(mask);
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) {
                    int new_mask = mask | (1 << i);
                    dp[new_mask] = min(dp[new_mask], dp[mask] + (nums1[k] ^ nums2[i]));
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};