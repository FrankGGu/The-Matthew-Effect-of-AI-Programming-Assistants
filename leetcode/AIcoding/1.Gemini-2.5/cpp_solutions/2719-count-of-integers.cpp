#include <string>
#include <vector>
#include <cstring>
#include <algorithm>

class Solution {
private:
    std::string S;
    int minS, maxS;
    long long memo[23][401][2][2];
    const int MOD = 1e9 + 7;

    long long dp(int index, int current_sum, bool is_tight, bool is_leading_zero) {
        if (index == S.length()) {
            if (is_leading_zero) return 0;
            return (current_sum >= minS && current_sum <= maxS);
        }
        if (memo[index][current_sum][is_tight][is_leading_zero] != -1) {
            return memo[index][current_sum][is_tight][is_leading_zero];
        }

        long long ans = 0;
        int upper_bound = is_tight ? (S[index] - '0') : 9;

        for (int digit = 0; digit <= upper_bound; ++digit) {
            if (is_leading_zero && digit == 0) {
                ans = (ans + dp(index + 1, 0, is_tight && (digit == upper_bound), true)) % MOD;
            } else {
                if (current_sum + digit <= maxS) {
                    ans = (ans + dp(index + 1, current_sum + digit, is_tight && (digit == upper_bound), false)) % MOD;
                }
            }
        }
        return memo[index][current_sum][is_tight][is_leading_zero] = ans;
    }

    long long solve(const std::string& s) {
        S = s;
        std::memset(memo, -1, sizeof(memo));
        return dp(0, 0, true, true);
    }

    std::string subtractOne(std::string n) {
        int i = n.length() - 1;
        while (i >= 0) {
            if (n[i] > '0') {
                n[i]--;
                break;
            } else {
                n[i] = '9';
                i--;
            }
        }
        if (n.length() > 1 && n[0] == '0') {
            return n.substr(1);
        }
        return n;
    }

public:
    int count(std::string num1, std::string num2, int min_sum, int max_sum) {
        minS = min_sum;
        maxS = max_sum;

        std::string num1_minus_1 = subtractOne(num1);

        long long ans2 = solve(num2);
        long long ans1 = solve(num1_minus_1);

        return (ans2 - ans1 + MOD) % MOD;
    }
};