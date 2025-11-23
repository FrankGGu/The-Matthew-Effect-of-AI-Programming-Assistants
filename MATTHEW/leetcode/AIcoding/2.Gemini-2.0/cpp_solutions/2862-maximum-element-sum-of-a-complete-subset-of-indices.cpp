#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    long long maximumSum(vector<int>& nums) {
        int n = nums.size();
        vector<long long> dp(n + 1, 0);
        long long ans = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j * j <= i; ++j) {
                if (i % j == 0) {
                    dp[i] += nums[i - 1];
                    if (j * j != i && i / j <= n) {
                    }
                }
            }
             ans = max(ans, dp[i]);
        }

        return ans;
    }
};