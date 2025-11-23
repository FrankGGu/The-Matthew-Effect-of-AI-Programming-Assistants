#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumXORSum(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<vector<int>> dp(1 << n, vector<int>(n + 1, INT_MAX));
        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int bits = __builtin_popcount(mask);
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) {
                    if (dp[mask][bits] != INT_MAX) {
                        dp[mask | (1 << i)][bits + 1] = min(dp[mask | (1 << i)][bits + 1], dp[mask][bits] + (nums1[bits] ^ nums2[i]));
                    }
                }
            }
        }

        int ans = INT_MAX;
        for (int i = 0; i <= n; ++i) {
            ans = min(ans, dp[(1 << n) - 1][i]);
        }

        return ans;
    }
};