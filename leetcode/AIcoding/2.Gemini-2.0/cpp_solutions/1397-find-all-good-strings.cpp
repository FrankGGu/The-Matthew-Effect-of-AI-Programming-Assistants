#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int findGoodStrings(int n, string s1, string s2, string evil) {
        int m = evil.size();
        int mod = 1e9 + 7;

        vector<int> lps(m, 0);
        int len = 0;
        for (int i = 1; i < m; i++) {
            while (len > 0 && evil[i] != evil[len]) {
                len = lps[len - 1];
            }
            if (evil[i] == evil[len]) {
                len++;
            }
            lps[i] = len;
        }

        vector<vector<vector<vector<int>>>> dp(n + 1, vector<vector<vector<int>>>(2, vector<vector<int>>(2, vector<int>(m, 0))));
        dp[0][1][1][0] = 1;

        for (int i = 0; i < n; i++) {
            for (int l = 0; l < 2; l++) {
                for (int r = 0; r < 2; r++) {
                    for (int k = 0; k < m; k++) {
                        for (char c = (l ? s1[i] : 'a'); c <= (r ? s2[i] : 'z'); c++) {
                            int new_k = k;
                            while (new_k > 0 && c != evil[new_k]) {
                                new_k = lps[new_k - 1];
                            }
                            if (c == evil[new_k]) {
                                new_k++;
                            }

                            if (new_k == m) continue;

                            dp[i + 1][l && (c == s1[i])][r && (c == s2[i])][new_k] = (dp[i + 1][l && (c == s1[i])][r && (c == s2[i])][new_k] + dp[i][l][r][k]) % mod;
                        }
                    }
                }
            }
        }

        int ans = 0;
        for (int l = 0; l < 2; l++) {
            for (int r = 0; r < 2; r++) {
                for (int k = 0; k < m; k++) {
                    ans = (ans + dp[n][l][r][k]) % mod;
                }
            }
        }

        return ans;
    }
};