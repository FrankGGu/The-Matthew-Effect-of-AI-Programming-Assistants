#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minDeletionColumns(vector<string>& strs) {
        int n = strs.size();
        int m = strs[0].size();
        vector<int> dp(m, 1);

        for (int j = 0; j < m; ++j) {
            for (int k = 0; k < j; ++k) {
                bool valid = true;
                for (int i = 0; i < n; ++i) {
                    if (strs[i][k] > strs[i][j]) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    dp[j] = max(dp[j], dp[k] + 1);
                }
            }
        }

        int maxLen = 0;
        for (int val : dp) {
            maxLen = max(maxLen, val);
        }

        return m - maxLen;
    }
};