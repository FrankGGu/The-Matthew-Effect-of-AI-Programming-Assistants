#include <vector>

class Solution {
public:
    int peopleAwareOfSecret(int n, int delay, int forget) {
        long long mod = 1e9 + 7;
        std::vector<long long> dp(n + 1, 0);
        dp[1] = 1;
        long long sharing_count = 0;

        for (int i = 2; i <= n; ++i) {
            if (i - delay > 0) {
                sharing_count = (sharing_count + dp[i - delay]) % mod;
            }
            if (i - forget > 0) {
                sharing_count = (sharing_count - dp[i - forget] + mod) % mod;
            }
            dp[i] = sharing_count;
        }

        long long total_aware = 0;
        for (int i = n - forget + 1; i <= n; ++i) {
            if (i > 0) {
                total_aware = (total_aware + dp[i]) % mod;
            }
        }
        return static_cast<int>(total_aware);
    }
};