#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumANDSum(vector<int>& nums, int numSlots) {
        int n = nums.size();
        int m = numSlots;
        int dp[n + 1][(int)pow(3, m)];
        memset(dp, 0, sizeof(dp));

        function<int(int, int)> solve = [&](int idx, int mask) {
            if (idx == n) {
                return 0;
            }

            if (dp[idx][mask] != 0) {
                return dp[idx][mask];
            }

            int ans = 0;
            for (int i = 0; i < m; ++i) {
                int digit = (mask / (int)pow(3, i)) % 3;
                if (digit > 0) {
                    int newMask = mask - (int)pow(3, i);
                    ans = max(ans, (nums[idx] & (i + 1)) + solve(idx + 1, newMask));
                }
            }

            return dp[idx][mask] = ans;
        };

        int initialMask = 0;
        for (int i = 0; i < m; ++i) {
            initialMask += 2 * (int)pow(3, i);
        }

        return solve(0, initialMask);
    }
};