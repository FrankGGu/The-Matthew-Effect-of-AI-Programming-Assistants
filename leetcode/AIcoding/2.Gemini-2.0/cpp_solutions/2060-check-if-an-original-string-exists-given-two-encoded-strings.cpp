#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool possiblyEquals(string s1, string s2) {
        int n1 = s1.size(), n2 = s2.size();
        vector<vector<vector<bool>>> dp(n1 + 1, vector<vector<bool>>(n2 + 1, vector<bool>(2001, false)));
        dp[0][0][1000] = true;

        for (int i = 0; i <= n1; ++i) {
            for (int j = 0; j <= n2; ++j) {
                for (int k = 0; k <= 2000; ++k) {
                    if (!dp[i][j][k]) continue;

                    if (i < n1 && isalpha(s1[i])) {
                        if (j < n2 && isalpha(s2[j]) && s1[i] == s2[j] && k == 1000) {
                            dp[i + 1][j + 1][k] = true;
                        } else if (k < 2000) {
                            dp[i + 1][j][k + 1] = true;
                        }
                    } else if (i < n1 && isdigit(s1[i])) {
                        int num = 0;
                        for (int l = i; l < n1 && isdigit(s1[l]) && l < i + 3; ++l) {
                            num = num * 10 + (s1[l] - '0');
                            if (k - num >= 0) {
                                dp[l + 1][j][k - num] = true;
                            }
                        }
                    } else if (j < n2 && isalpha(s2[j])) {
                        if (k > 0) {
                            dp[i][j + 1][k - 1] = true;
                        }
                    } else if (j < n2 && isdigit(s2[j])) {
                        int num = 0;
                        for (int l = j; l < n2 && isdigit(s2[l]) && l < j + 3; ++l) {
                            num = num * 10 + (s2[l] - '0');
                            if (k + num <= 2000) {
                                dp[i][l + 1][k + num] = true;
                            }
                        }
                    }
                }
            }
        }

        return dp[n1][n2][1000];
    }
};