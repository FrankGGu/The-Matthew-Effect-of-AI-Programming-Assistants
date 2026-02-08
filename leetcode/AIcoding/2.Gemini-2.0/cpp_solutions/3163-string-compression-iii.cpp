#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getLengthOfOptimalCompression(string s, int k) {
        int n = s.length();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 10000));
        dp[0][0] = 0;
        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                if (j > 0) {
                    dp[i][j] = min(dp[i][j], dp[i - 1][j - 1]);
                }
                int count = 0, deleted = 0;
                for (int l = i; l >= 1; --l) {
                    if (s[l - 1] == s[i - 1]) {
                        count++;
                    } else {
                        deleted++;
                    }
                    if (j >= deleted) {
                        int len = 1;
                        if (count >= 100) {
                            len = 4;
                        } else if (count >= 10) {
                            len = 3;
                        } else if (count > 1) {
                            len = 2;
                        }
                        dp[i][j] = min(dp[i][j], dp[l - 1][j - deleted] + len);
                    }
                }
            }
        }
        return dp[n][k];
    }
};