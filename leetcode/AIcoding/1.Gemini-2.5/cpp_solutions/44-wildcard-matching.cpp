#include <string>
#include <vector>

class Solution {
public:
    bool isMatch(std::string s, std::string p) {
        int s_len = s.length();
        int p_len = p.length();

        std::vector<bool> dp(p_len + 1, false);

        dp[0] = true;

        for (int j = 1; j <= p_len; ++j) {
            if (p[j-1] == '*') {
                dp[j] = dp[j-1];
            }
        }

        for (int i = 1; i <= s_len; ++i) {
            bool prev_diag = dp[0]; 
            dp[0] = false; 

            for (int j = 1; j <= p_len; ++j) {
                bool temp = dp[j]; 

                if (p[j-1] == '?' || s[i-1] == p[j-1]) {
                    dp[j] = prev_diag;
                } else if (p[j-1] == '*') {
                    dp[j] = dp[j-1] || temp;
                } else {
                    dp[j] = false;
                }
                prev_diag = temp; 
            }
        }

        return dp[p_len];
    }
};