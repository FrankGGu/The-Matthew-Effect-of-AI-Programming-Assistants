#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numBeautifulPartitions(vector<string>& s, int k) {
        int n = s.size();
        if (n == 0 || k == 0) return 0;
        vector<vector<int>> dp(k + 1, vector<int>(n, 0));
        vector<bool> isVowel = {false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true};

        for (int i = 0; i < n; ++i) {
            if (isVowel[s[i][0] - 'a']) {
                dp[1][i] = 1;
            }
        }

        for (int i = 2; i <= k; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!isVowel[s[j][0] - 'a']) continue;
                for (int m = 0; m < j; ++m) {
                    if (isVowel[s[m][0] - 'a']) {
                        dp[i][j] += dp[i - 1][m];
                    }
                }
            }
        }

        return dp[k][n - 1];
    }
};