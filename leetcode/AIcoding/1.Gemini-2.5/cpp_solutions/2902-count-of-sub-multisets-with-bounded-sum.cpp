#include <vector>
#include <unordered_map>

class Solution {
public:
    int countSubMultisets(std::vector<int>& nums, int l, int r) {
        const int MOD = 1e9 + 7;

        std::unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        std::vector<int> dp(r + 1, 0);
        dp[0] = 1;

        int zero_count = counts.count(0) ? counts[0] : 0;
        counts.erase(0);

        for (auto const& [x, c] : counts) {
            std::vector<int> next_dp = dp;
            for (int rem = 0; rem < x; ++rem) {
                long long window_sum = 0;
                for (int j = rem; j <= r; j += x) {
                    window_sum += dp[j];
                    if (j >= rem + (c + 1) * x) {
                        window_sum -= dp[j - (c + 1) * x];
                    }
                    next_dp[j] = (window_sum % MOD + MOD) % MOD;
                }
            }
            dp = next_dp;
        }

        long long total_count = 0;
        for (int i = l; i <= r; ++i) {
            total_count = (total_count + dp[i]) % MOD;
        }

        return (total_count * (zero_count + 1)) % MOD;
    }
};