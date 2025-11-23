class Solution {
public:
    int minimumXORSum(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<vector<int>> dp(1 << n, vector<int>(n + 1, INT_MAX));
        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int i = __builtin_popcount(mask);
            if (i > n) continue;

            for (int j = 0; j < n; ++j) {
                if (!(mask & (1 << j))) {
                    dp[mask | (1 << j)][i + 1] = min(dp[mask | (1 << j)][i + 1], 
                                                        dp[mask][i] + (nums1[i] ^ nums2[j]));
                }
            }
        }

        return *min_element(dp[(1 << n) - 1].begin(), dp[(1 << n) - 1].end());
    }
};