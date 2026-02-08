#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDeletionSize(vector<string>& strs) {
        int n = strs.size();
        int m = strs[0].size();
        vector<int> dp(m, 1);
        int maxLen = 1;

        for (int i = 1; i < m; ++i) {
            for (int j = 0; j < i; ++j) {
                bool valid = true;
                for (int k = 0; k < n; ++k) {
                    if (strs[k][j] > strs[k][i]) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
            maxLen = max(maxLen, dp[i]);
        }

        return m - maxLen;
    }
};