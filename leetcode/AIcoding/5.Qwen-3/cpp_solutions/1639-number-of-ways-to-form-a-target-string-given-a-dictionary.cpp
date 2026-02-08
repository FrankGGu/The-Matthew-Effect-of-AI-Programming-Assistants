#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numWays(vector<string>& words, string target) {
        int n = words.size();
        int m = words[0].size();
        int k = target.size();

        vector<vector<int>> count(m, vector<int>(26, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                count[i][words[j][i] - 'a']++;
            }
        }

        vector<vector<int>> dp(k + 1, vector<int>(m + 1, 0));

        for (int i = 0; i <= m; ++i) {
            dp[0][i] = 1;
        }

        for (int i = 1; i <= k; ++i) {
            for (int j = i; j <= m; ++j) {
                dp[i][j] = (dp[i][j - 1] + (long long)count[j - 1][target[i - 1] - 'a'] * dp[i - 1][j - 1]) % 1000000007;
            }
        }

        return dp[k][m];
    }
};