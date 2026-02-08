#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMaximumLength(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        vector<int> dp(n, 0);
        vector<int> last(n + 1, -1);
        last[0] = 0;

        for (int i = 0; i < n; ++i) {
            dp[i] = i > 0 ? dp[i - 1] : 0;
            for (int j = 0; j <= i; ++j) {
                long long sum = prefixSum[i + 1] - prefixSum[j];
                if (sum >= nums[i]) {
                    dp[i] = max(dp[i], (j > 0 ? dp[j - 1] : 0) + 1);
                }
            }

        }

        return dp[n - 1];
    }
};