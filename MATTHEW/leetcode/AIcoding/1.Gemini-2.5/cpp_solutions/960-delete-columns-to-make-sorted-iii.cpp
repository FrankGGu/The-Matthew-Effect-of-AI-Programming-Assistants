#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int minDeletionSize(std::vector<std::string>& strs) {
        int R = strs.size();
        if (R <= 1) {
            return 0;
        }
        int C = strs[0].size();

        std::vector<int> dp(C, 1);
        int max_len = 1;

        for (int j = 1; j < C; ++j) {
            for (int i = 0; i < j; ++i) {
                bool compatible = true;
                for (int k = 0; k < R; ++k) {
                    if (strs[k][i] > strs[k][j]) {
                        compatible = false;
                        break;
                    }
                }

                if (compatible) {
                    dp[j] = std::max(dp[j], 1 + dp[i]);
                }
            }
            max_len = std::max(max_len, dp[j]);
        }

        return C - max_len;
    }
};