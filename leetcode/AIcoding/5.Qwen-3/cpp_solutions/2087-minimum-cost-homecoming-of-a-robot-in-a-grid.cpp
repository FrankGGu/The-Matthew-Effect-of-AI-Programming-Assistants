#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minCost(int rows, int cols, vector<int>& onTime, vector<int>& offTime, vector<vector<int>>& robot, vector<vector<int>>& factory) {
        int n = robot.size();
        int m = factory.size();
        vector<vector<int>> dp(n, vector<int>(m, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                int cost = abs(robot[i][0] - factory[j][0]) * onTime[0] + abs(robot[i][1] - factory[j][1]) * onTime[1];
                if (i == 0) {
                    dp[i][j] = cost;
                } else {
                    dp[i][j] = cost;
                    for (int k = 0; k < j; ++k) {
                        dp[i][j] = min(dp[i][j], dp[i-1][k] + cost);
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int j = 0; j < m; ++j) {
            result = min(result, dp[n-1][j]);
        }

        return result;
    }
};