#include <vector>

using namespace std;

class Solution {
public:
    int countPartitions(vector<int>& nums, int k) {
        long long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        if (sum < 2 * k) {
            return 0;
        }

        int n = nums.size();
        int mod = 1e9 + 7;
        vector<int> dp(k, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int i = k - 1; i >= num; --i) {
                dp[i] = (dp[i] + dp[i - num]) % mod;
            }
        }

        long long lessThanK = 0;
        for (int i = 0; i < k; ++i) {
            lessThanK = (lessThanK + dp[i]) % mod;
        }

        long long total = 1;
        for (int i = 0; i < n; ++i) {
            total = (total * 2) % mod;
        }

        long long result = (total - 2 * lessThanK % mod + mod) % mod;
        return (int)result;
    }
};