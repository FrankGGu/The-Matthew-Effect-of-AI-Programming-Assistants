#include <string>
#include <vector>

class Solution {
public:
    int numDistinct(std::string s, std::string t) {
        int s_len = s.length();
        int t_len = t.length();

        std::vector<std::vector<long long>> dp(s_len + 1, std::vector<long long>(t_len + 1, 0));

        for (int i = 0; i <= s_len; ++i) {
            dp[i][0] = 1;
        }

        for (int i = 1; i <= s_len; ++i) {
            for (int j = 1; j <= t_len; ++j) {
                dp[i][j] = dp[i-1][j]; // Option 1: Don't use s[i-1]

                if (s[i-1] == t[j-1]) {
                    dp[i][j] += dp[i-1][j-1]; // Option 2: Use s[i-1] to match t[j-1]
                }
            }
        }

        return static_cast<int>(dp[s_len][t_len]);
    }
};