#include <vector>

class Solution {
public:
    int countWinningSequences(int n, int k) {
        if (n > 2 && n - 2 >= k) {
            return 0;
        }

        long long MOD = 1e9 + 7;

        if (n <= 2) {
            long long res = 1;
            long long base = k;
            int p = n;
            while (p > 0) {
                if (p % 2 == 1) res = (res * base) % MOD;
                base = (base * base) % MOD;
                p /= 2;
            }
            return res;
        }

        std::vector<long long> dp(k, 0);
        dp[0] = 1;

        for (int i = 1; i <= n - 2; ++i) {
            std::vector<long long> pref(k, 0);
            pref[0] = dp[0];
            for (int s = 1; s < k; ++s) {
                pref[s] = (pref[s - 1] + dp[s]) % MOD;
            }

            std::vector<long long> new_dp(k, 0);
            for (int s = i; s < k; ++s) {
                long long upper = pref[s - 1];
                long long lower = (s - k - 1 >= 0) ? pref[s - k - 1] : 0;
                new_dp[s] = (upper - lower + MOD) % MOD;
            }
            dp = new_dp;
        }

        std::vector<long long> N = dp;
        std::vector<long long> prefN(k, 0);
        if (k > 0) {
            prefN[0] = N[0];
            for (int s = 1; s < k; ++s) {
                prefN[s] = (prefN[s - 1] + N[s]) % MOD;
            }
        }

        long long sum_counts = 0;
        if (k > 0) {
            std::vector<long long> prefPrefN(k, 0);
            prefPrefN[0] = prefN[0];
            for (int s = 1; s < k; ++s) {
                prefPrefN[s] = (prefPrefN[s - 1] + prefN[s]) % MOD;
            }
            sum_counts = prefPrefN[k - 1];
        }

        long long ans = (static_cast<long long>(k) * sum_counts) % MOD;
        return static_cast<int>(ans);
    }
};