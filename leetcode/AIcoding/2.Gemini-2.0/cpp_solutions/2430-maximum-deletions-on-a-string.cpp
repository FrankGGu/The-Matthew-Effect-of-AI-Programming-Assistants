#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int deleteString(string s) {
        int n = s.size();
        vector<int> dp(n, 1);
        vector<vector<bool>> lcp(n, vector<bool>(n, false));

        for (int len = 1; len <= n / 2; ++len) {
            for (int i = 0; i + 2 * len <= n; ++i) {
                if (s.substr(i, len) == s.substr(i + len, len)) {
                    lcp[i][i + len] = true;
                }
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            for (int j = i + 1; j < n; ++j) {
                if (lcp[i][j]) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[0];
    }
};