#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDistance(string word) {
        int n = word.length();
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(27, vector<int>(27, 1e9)));
        dp[0][26][26] = 0;

        for (int i = 0; i < n; ++i) {
            int c = word[i] - 'A';
            for (int j = 0; j < 27; ++j) {
                for (int k = 0; k < 27; ++k) {
                    if (dp[i][j][k] != 1e9) {
                        int dist1 = (j == 26) ? 0 : abs(c / 6 - j / 6) + abs(c % 6 - j % 6);
                        int dist2 = (k == 26) ? 0 : abs(c / 6 - k / 6) + abs(c % 6 - k % 6);
                        dp[i + 1][c][k] = min(dp[i + 1][c][k], dp[i][j][k] + dist1);
                        dp[i + 1][j][c] = min(dp[i + 1][j][c], dp[i][j][k] + dist2);
                    }
                }
            }
        }

        int ans = 1e9;
        for (int i = 0; i < 27; ++i) {
            for (int j = 0; j < 27; ++j) {
                ans = min(ans, dp[n][i][j]);
            }
        }
        return ans;
    }
};