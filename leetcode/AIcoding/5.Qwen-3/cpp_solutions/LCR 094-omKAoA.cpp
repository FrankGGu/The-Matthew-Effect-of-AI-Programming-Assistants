#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minCut(string s) {
        int n = s.size();
        vector<int> dp(n, 0);
        vector<vector<bool>> isPalindrome(n, vector<bool>(n, false));

        for (int i = 0; i < n; ++i) {
            isPalindrome[i][i] = true;
        }

        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == s[i + 1]) {
                isPalindrome[i][i + 1] = true;
            }
        }

        for (int length = 3; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                if (s[i] == s[j] && isPalindrome[i + 1][j - 1]) {
                    isPalindrome[i][j] = true;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            dp[i] = i;
        }

        for (int i = 1; i < n; ++i) {
            if (isPalindrome[0][i]) {
                dp[i] = 0;
                continue;
            }
            for (int j = 0; j < i; ++j) {
                if (isPalindrome[j + 1][i]) {
                    dp[i] = min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n - 1];
    }
};