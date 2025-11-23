#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    double champagneTower(vector<int>& poured, int query_row, int query_glass) {
        vector<vector<double>> dp(query_row + 2, vector<double>(query_row + 2, 0.0));
        dp[0][0] = poured;
        for (int row = 0; row <= query_row; ++row) {
            for (int glass = 0; glass <= row; ++glass) {
                if (dp[row][glass] > 1.0) {
                    double overflow = dp[row][glass] - 1.0;
                    dp[row + 1][glass] += overflow / 2.0;
                    dp[row + 1][glass + 1] += overflow / 2.0;
                    dp[row][glass] = 1.0;
                }
            }
        }
        return dp[query_row][query_glass];
    }
};