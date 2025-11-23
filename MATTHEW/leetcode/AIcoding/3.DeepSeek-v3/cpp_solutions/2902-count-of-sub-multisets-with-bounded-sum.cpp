#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int countSubMultisets(vector<int>& nums, int l, int r) {
        const int MOD = 1e9 + 7;
        vector<int> dp(r + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = r; j >= num; --j) {
                dp[j] = (dp[j] + dp[j - num]) % MOD;
            }
        }

        int res = 0;
        for (int i = l; i <= r; ++i) {
            res = (res + dp[i]) % MOD;
        }
        return res;
    }
};