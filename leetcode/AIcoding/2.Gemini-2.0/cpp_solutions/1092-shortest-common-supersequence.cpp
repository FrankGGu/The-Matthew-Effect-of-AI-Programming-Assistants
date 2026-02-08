#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string shortestCommonSupersequence(string str1, string str2) {
        int n = str1.size();
        int m = str2.size();

        vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                if (str1[i - 1] == str2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }

        int i = n, j = m;
        string lcs = "";
        while (i > 0 && j > 0) {
            if (str1[i - 1] == str2[j - 1]) {
                lcs = str1[i - 1] + lcs;
                i--;
                j--;
            } else if (dp[i - 1][j] > dp[i][j - 1]) {
                i--;
            } else {
                j--;
            }
        }

        string result = "";
        i = 0, j = 0;
        for (char c : lcs) {
            while (str1[i] != c) {
                result += str1[i];
                i++;
            }
            while (str2[j] != c) {
                result += str2[j];
                j++;
            }
            result += c;
            i++;
            j++;
        }

        while (i < n) {
            result += str1[i];
            i++;
        }

        while (j < m) {
            result += str2[j];
            j++;
        }

        return result;
    }
};