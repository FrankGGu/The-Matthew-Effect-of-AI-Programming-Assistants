#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimumXORSum(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();
        std::vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int cnt = __builtin_popcount(mask);
            for (int j = 0; j < n; ++j) {
                if (!(mask & (1 << j))) {
                    int new_mask = mask | (1 << j);
                    dp[new_mask] = std::min(dp[new_mask], dp[mask] + (nums1[cnt] ^ nums2[j]));
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};