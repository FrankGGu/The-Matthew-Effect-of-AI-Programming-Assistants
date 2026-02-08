#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int longestValidParentheses(string s) {
        int n = s.size();
        if (n <= 1) return 0;
        vector<int> dp(n, 0);
        int maxLen = 0;

        for (int i = 1; i < n; i++) {
            if (s[i] == ')') {
                if (s[i-1] == '(') {
                    dp[i] = (i >= 2 ? dp[i-2] : 0) + 2;
                } else {
                    int j = i - dp[i-1] - 1;
                    if (j >= 0 && s[j] == '(') {
                        dp[i] = dp[i-1] + 2;
                        if (j - 1 >= 0) {
                            dp[i] += dp[j-1];
                        }
                    }
                }
                maxLen = max(maxLen, dp[i]);
            }
        }
        return maxLen;
    }
};