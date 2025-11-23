#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countWinningSequences(int n) {
        vector<vector<int>> dp(n + 1, vector<int>(3, 0));
        vector<vector<int>> prev(3, vector<int>(3, 0));

        for (int i = 0; i < 3; ++i) {
            prev[i][i] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 0; j < 3; ++j) {
                for (int k = 0; k < 3; ++k) {
                    if (j != k) {
                        dp[i][j] += prev[k][j];
                    }
                }
            }
            prev = dp;
        }

        int result = 0;
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                result += prev[i][j];
            }
        }
        return result;
    }
};