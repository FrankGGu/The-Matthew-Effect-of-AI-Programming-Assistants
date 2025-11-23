#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numPermutations(int n, const string& s) {
        vector<vector<int>> dp(n + 1, vector<int>(n + 1, 0));
        for (int i = 0; i <= n; ++i) {
            dp[0][i] = 1;
        }
        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= n - i; ++j) {
                if (s[i - 1] == 'D') {
                    for (int k = 0; k < j; ++k) {
                        dp[i][j] += dp[i - 1][k];
                    }
                } else {
                    for (int k = j; k < i; ++k) {
                        dp[i][j] += dp[i - 1][k];
                    }
                }
            }
        }
        return dp[n][0];
    }

    int validPermutations(string s) {
        return numPermutations(s.length(), s);
    }
};