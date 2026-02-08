#include <vector>

using namespace std;

class Solution {
public:
    int countSteppingNumbers(int low, int high) {
        const int MOD = 1e9 + 7;
        auto count = [&](int n) {
            string s = to_string(n);
            int len = s.size();
            vector<vector<vector<int>>> dp(len + 1, vector<vector<int>>(10, vector<int>(2, 0)));
            for (int i = 0; i < 10; ++i) {
                dp[1][i][1] = 1;
            }
            int ans = 0;
            for (int i = 1; i < len; ++i) {
                for (int j = 0; j < 10; ++j) {
                    for (int k = 0; k < 2; ++k) {
                        if (dp[i][j][k] == 0) continue;
                        for (int d = 0; d < 10; ++d) {
                            if (abs(j - d) == 1) {
                                dp[i + 1][d][k] = (dp[i + 1][d][k] + dp[i][j][k]) % MOD;
                            }
                        }
                    }
                }
            }
            for (int i = 1; i < len; ++i) {
                for (int j = 1; j < 10; ++j) {
                    ans = (ans + dp[i][j][0] + dp[i][j][1]) % MOD;
                }
            }

            vector<vector<int>> dp2(len + 1, vector<int>(2, 0));
            dp2[0][1] = 1;
            for (int i = 0; i < len; ++i) {
                int digit = s[i] - '0';
                for (int j = 0; j < 10; ++j) {
                    for (int k = 0; k < 2; ++k) {
                        if (dp[i][j][k] == 0) continue;

                    }
                }
                for (int d = 0; d < 10; ++d) {
                    if (dp2[i][0] == 0 && dp2[i][1] == 0) break;
                    if (i == 0 && d == 0) continue;

                    if (abs(d - (i == 0 ? -2 : (s[i - 1] - '0'))) != 1 && i > 0) continue;
                    if(abs(d - (i == 0 ? -2 : (s[i - 1] - '0'))) != 1 && i == 0) continue;

                    if (dp2[i][1]) {
                        if (d < digit && abs(d - (i == 0 ? -2 : (s[i - 1] - '0'))) == 1) {
                            dp2[i + 1][0] = (dp2[i + 1][0] + dp2[i][1]) % MOD;
                        } else if (d == digit && abs(d - (i == 0 ? -2 : (s[i - 1] - '0'))) == 1) {
                            dp2[i + 1][1] = (dp2[i + 1][1] + dp2[i][1]) % MOD;
                        }
                    }
                    if (dp2[i][0]) {
                        if (abs(d - (i == 0 ? -2 : (s[i - 1] - '0'))) == 1) {
                            dp2[i + 1][0] = (dp2[i + 1][0] + dp2[i][0]) % MOD;
                        }
                    }
                }
            }
            ans = (ans + dp2[len][0] + dp2[len][1]) % MOD;
            bool stepping = true;
            for(int i = 1; i < len; i++) {
                if(abs((s[i] - '0') - (s[i-1] - '0')) != 1) {
                    stepping = false;
                    break;
                }
            }
            return ans;
        };
        int ans_high = count(high);
        int ans_low = count(low - 1);
        return (ans_high - ans_low + MOD) % MOD;
    }
};