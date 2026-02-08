#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCut(string s) {
        int n = s.length();
        if (n <= 1) {
            return 0;
        }

        vector<int> dp(n + 1);
        for (int i = 0; i <= n; ++i) {
            dp[i] = i - 1;
        }

        for (int i = 0; i < n; ++i) {
            // Odd length palindromes centered at i
            for (int j = 0; i - j >= 0 && i + j < n && s[i - j] == s[i + j]; ++j) {
                dp[i + j + 1] = min(dp[i + j + 1], dp[i - j] + 1);
            }
            // Even length palindromes centered at i, i+1
            for (int j = 0; i - j >= 0 && i + 1 + j < n && s[i - j] == s[i + 1 + j]; ++j) {
                dp[i + 1 + j + 1] = min(dp[i + 1 + j + 1], dp[i - j] + 1);
            }
        }

        return dp[n];
    }
};