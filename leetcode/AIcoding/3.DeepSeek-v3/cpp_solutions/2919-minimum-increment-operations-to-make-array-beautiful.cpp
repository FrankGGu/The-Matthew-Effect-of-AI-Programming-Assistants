#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    long long minIncrementOperations(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> dp(n, 0);

        for (int i = 0; i < n; ++i) {
            if (i < 3) {
                dp[i] = max(0, k - nums[i]);
            } else {
                long long min_prev = min({dp[i-1], dp[i-2], dp[i-3]});
                dp[i] = min_prev + max(0, k - nums[i]);
            }
        }

        if (n < 3) {
            return 0;
        } else {
            return min({dp[n-1], dp[n-2], dp[n-3]});
        }
    }
};