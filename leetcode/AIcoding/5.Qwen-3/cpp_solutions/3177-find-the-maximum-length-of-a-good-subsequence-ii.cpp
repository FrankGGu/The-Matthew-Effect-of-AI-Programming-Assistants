#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxLength(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(n, vector<int>(26, 0));

        for (int i = 0; i < n; ++i) {
            int c = nums[i];
            for (int j = 0; j < 26; ++j) {
                if (j == c) {
                    dp[i][j] = 1;
                    for (int l = 0; l < 26; ++l) {
                        if (l != j && i - 1 >= 0) {
                            dp[i][j] = max(dp[i][j], dp[i-1][l] + 1);
                        }
                    }
                } else {
                    if (i - 1 >= 0) {
                        dp[i][j] = dp[i-1][j];
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 26; ++j) {
                if (dp[i][j] > result) {
                    result = dp[i][j];
                }
            }
        }

        return result;
    }
};