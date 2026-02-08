#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maxDeletions(std::string s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        long long MOD1 = 1e9 + 7;
        long long BASE1 = 31;
        long long MOD2 = 1e9 + 9;
        long long BASE2 = 37;

        std::vector<long long> p1(n + 1);
        std::vector<long long> p2(n + 1);
        std::vector<long long> h1(n + 1, 0);
        std::vector<long long> h2(n + 1, 0);

        p1[0] = 1;
        p2[0] = 1;
        for (int i = 1; i <= n; ++i) {
            p1[i] = (p1[i - 1] * BASE1) % MOD1;
            p2[i] = (p2[i - 1] * BASE2) % MOD2;
            h1[i] = (h1[i - 1] * BASE1 + (s[i - 1] - 'a' + 1)) % MOD1;
            h2[i] = (h2[i - 1] * BASE2 + (s[i - 1] - 'a' + 1)) % MOD2;
        }

        auto get_sub_hash = [&](const std::vector<long long>& h_arr, const std::vector<long long>& p_arr, long long mod, int start_idx, int length) {
            long long val = (h_arr[start_idx + length] - (h_arr[start_idx] * p_arr[length]) % mod + mod) % mod;
            return val;
        };

        auto is_equal = [&](int idx1, int idx2, int length) {
            if (length == 0) return true;
            if (idx1 + length > n || idx2 + length > n) return false;

            long long hash1_1 = get_sub_hash(h1, p1, MOD1, idx1, length);
            long long hash1_2 = get_sub_hash(h1, p1, MOD1, idx2, length);
            if (hash1_1 != hash1_2) return false;

            long long hash2_1 = get_sub_hash(h2, p2, MOD2, idx1, length);
            long long hash2_2 = get_sub_hash(h2, p2, MOD2, idx2, length);
            return hash2_1 == hash2_2;
        };

        std::vector<int> dp(n + 1, 0);

        for (int i = n - 1; i >= 0; --i) {
            int current_best_from_rules = 0;
            bool rule2_possible = false;

            for (int len = 1; i + 2 * len <= n; ++len) {
                if (is_equal(i, i + len, len)) {
                    rule2_possible = true;
                    current_best_from_rules = std::max(current_best_from_rules, 1 + dp[i + 2 * len]);
                }
            }

            if (rule2_possible) {
                dp[i] = current_best_from_rules;
            } else {
                dp[i] = 1 + dp[i + 1];
            }

            dp[i] = std::max(dp[i], 1);
        }

        return dp[0];
    }
};