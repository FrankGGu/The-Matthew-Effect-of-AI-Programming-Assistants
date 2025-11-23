#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numDecodings(string s) {
        int n = s.size();
        vector<long> dp(n + 1, 0);
        dp[0] = 1;
        dp[1] = s[0] == '*' ? 9 : (s[0] == '0' ? 0 : 1);

        for (int i = 2; i <= n; ++i) {
                        if (s[i - 1] == '*') {
                dp[i] += dp[i - 1] * 9;
            } else if (s[i - 1] != '0') {
                dp[i] += dp[i - 1];
            }

                        if (s[i - 2] == '*') {
                if (s[i - 1] == '*') {
                    dp[i] += dp[i - 2] * 15;
                } else if (s[i - 1] >= '0' && s[i - 1] <= '6') {
                    dp[i] += dp[i - 2] * 2;
                } else {
                    dp[i] += dp[i - 2] * 1;
                }
            } else if (s[i - 2] == '1') {
                if (s[i - 1] == '*') {
                    dp[i] += dp[i - 2] * 9;
                } else {
                    dp[i] += dp[i - 2];
                }
            } else if (s[i - 2] == '2') {
                if (s[i - 1] == '*') {
                    dp[i] += dp[i - 2] * 6;
                } else if (s[i - 1] >= '0' && s[i - 1] <= '6') {
                    dp[i] += dp[i - 2];
                }
            }

            dp[i] %= 1000000007;
        }

        return dp[n];
    }
};