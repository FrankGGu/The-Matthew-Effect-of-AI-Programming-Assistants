#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int specialPerm(vector<int>& nums) {
        int n = nums.size();
        int mod = 1e9 + 7;
        vector<vector<int>> dp(1 << n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = 1;
        }

        for (int mask = 0; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (dp[mask][i] > 0) {
                    for (int j = 0; j < n; ++j) {
                        if (!(mask & (1 << j)) && (nums[i] % nums[j] == 0 || nums[j] % nums[i] == 0)) {
                            dp[mask | (1 << j)][j] = (dp[mask | (1 << j)][j] + dp[mask][i]) % mod;
                        }
                    }
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < n; ++i) {
            ans = (ans + dp[(1 << n) - 1][i]) % mod;
        }

        return ans;
    }
};