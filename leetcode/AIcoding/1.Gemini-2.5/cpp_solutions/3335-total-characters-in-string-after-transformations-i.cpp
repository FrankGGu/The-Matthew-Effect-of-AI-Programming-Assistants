#include <vector>
#include <string>
#include <array>
#include <utility>

using namespace std;

class Solution {
public:
    long long totalCharacters(string s, vector<pair<char, string>>& transformations, int k) {
        long long MOD = 1e9 + 7;
        int N = 26;

        array<string, 26> rules;
        array<bool, 26> has_rule{};

        for (const auto& p : transformations) {
            rules[p.first - 'a'] = p.second;
            has_rule[p.first - 'a'] = true;
        }

        vector<long long> dp(N, 1);

        for (int i = 0; i < k; ++i) {
            vector<long long> next_dp(N, 0);
            for (int j = 0; j < N; ++j) {
                if (has_rule[j]) {
                    const string& t = rules[j];
                    for (char ch : t) {
                        next_dp[j] = (next_dp[j] + dp[ch - 'a']) % MOD;
                    }
                } else {
                    next_dp[j] = dp[j];
                }
            }
            dp = next_dp;
        }

        long long total_len = 0;
        for (char c : s) {
            total_len = (total_len + dp[c - 'a']) % MOD;
        }

        return total_len;
    }
};