#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimizeConcatenatedLength(vector<string>& words) {
        int n = words.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(26, vector<int>(26, 1e9)));
        dp[0][words[0][0] - 'a'][words[0].back() - 'a'] = words[0].length();

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < 26; ++j) {
                for (int k = 0; k < 26; ++k) {
                    if (dp[i - 1][j][k] != 1e9) {
                        int len = words[i].length();
                        int first = words[i][0] - 'a';
                        int last = words[i].back() - 'a';

                        if (words[i][0] == (char)('a' + k)) {
                            dp[i][j][last] = min(dp[i][j][last], dp[i - 1][j][k] + len - 1);
                        } else {
                            dp[i][j][last] = min(dp[i][j][last], dp[i - 1][j][k] + len);
                        }

                        if (words[i].back() == (char)('a' + j)) {
                            dp[i][first][k] = min(dp[i][first][k], dp[i - 1][j][k] + len - 1);
                        } else {
                            dp[i][first][k] = min(dp[i][first][k], dp[i - 1][j][k] + len);
                        }
                    }
                }
            }
        }

        int ans = 1e9;
        for (int j = 0; j < 26; ++j) {
            for (int k = 0; k < 26; ++k) {
                ans = min(ans, dp[n - 1][j][k]);
            }
        }

        return ans;
    }
};