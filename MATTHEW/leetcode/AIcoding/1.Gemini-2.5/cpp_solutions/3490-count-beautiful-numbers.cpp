#include <string>
#include <vector>
#include <cstring>

using namespace std;

class Solution {
public:
    long long dp[20][101][101][2];
    string S;
    int K_val;

    long long solve(int idx, bool tight, int current_sum_mod_k, int current_num_mod_k, bool is_started) {
        if (idx == S.length()) {
            return is_started && current_sum_mod_k == 0 && current_num_mod_k == 0;
        }

        if (!tight && is_started && dp[idx][current_sum_mod_k][current_num_mod_k][is_started] != -1) {
            return dp[idx][current_sum_mod_k][current_num_mod_k][is_started];
        }

        long long ans = 0;
        int upper_bound = tight ? (S[idx] - '0') : 9;

        for (int digit = 0; digit <= upper_bound; ++digit) {
            if (is_started || digit > 0) {
                int new_sum_mod_k = (current_sum_mod_k + digit) % K_val;
                int new_num_mod_k = (int)(((long long)current_num_mod_k * 10 + digit) % K_val);
                ans += solve(idx + 1, tight && (digit == upper_bound), new_sum_mod_k, new_num_mod_k, true);
            } else {
                ans += solve(idx + 1, tight && (digit == upper_bound), 0, 0, false);
            }
        }

        if (!tight && is_started) {
            dp[idx][current_sum_mod_k][current_num_mod_k][is_started] = ans;
        }
        return ans;
    }

    int countBeautifulNumbers(long long n, int k) {
        S = to_string(n);
        K_val = k;
        memset(dp, -1, sizeof(dp));

        return solve(0, true, 0, 0, false);
    }
};