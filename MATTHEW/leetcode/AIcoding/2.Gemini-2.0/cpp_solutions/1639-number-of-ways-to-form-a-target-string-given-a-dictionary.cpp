#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numWays(vector<string>& words, string target) {
        int m = target.length();
        int n = words[0].length();
        int MOD = 1e9 + 7;

        vector<vector<int>> count(n, vector<int>(26, 0));
        for (int j = 0; j < n; ++j) {
            for (const string& word : words) {
                count[j][word[j] - 'a']++;
            }
        }

        vector<vector<long long>> dp(m + 1, vector<long long>(n + 1, 0));
        dp[0][0] = 1;

        for (int i = 0; i <= m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (dp[i][j] > 0) {
                    dp[i][j + 1] = (dp[i][j + 1] + dp[i][j]) % MOD;
                    if (i < m) {
                        int charIndex = target[i] - 'a';
                        dp[i + 1][j + 1] = (dp[i + 1][j + 1] + dp[i][j] * count[j][charIndex]) % MOD;
                    }
                }
            }
        }

        return dp[m][n];
    }
};