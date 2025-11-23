#include <vector>
#include <numeric>

class Solution {
public:
    int countPartitions(std::vector<int>& nums, int k) {
        long long total_sum = 0;
        for (int num : nums) {
            total_sum += num;
        }

        if (total_sum < 2LL * k) {
            return 0;
        }

        int MOD = 1e9 + 7;
        int n = nums.size();

        auto power = [&](long long base, long long exp) {
            long long res = 1;
            base %= MOD;
            while (exp > 0) {
                if (exp % 2 == 1) res = (res * base) % MOD;
                base = (base * base) % MOD;
                exp /= 2;
            }
            return res;
        };

        long long total_ways = power(2, n);

        std::vector<int> dp(k, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = k - 1; j >= num; --j) {
                dp[j] = (dp[j] + dp[j - num]) % MOD;
            }
        }

        long long bad_subsequences = 0;
        for (int i = 0; i < k; ++i) {
            bad_subsequences = (bad_subsequences + dp[i]) % MOD;
        }

        long long bad_partitions = (2 * bad_subsequences) % MOD;

        long long ans = (total_ways - bad_partitions + MOD) % MOD;

        return static_cast<int>(ans);
    }
};