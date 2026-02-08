#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTotalDistance(vector<int>& robot, vector<vector<int>>& factory) {
        sort(robot.begin(), robot.end());
        sort(factory.begin(), factory.end());

        int n = robot.size();
        int m = factory.size();

        vector<vector<int>> dp(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            int dist = 0;
            for (int j = 0; j < n; ++j) {
                dist += abs(robot[j] - factory[i][0]);
                if (i == 0) {
                    dp[i][j] = dist;
                } else {
                    dp[i][j] = dp[i-1][j];
                    for (int k = 0; k < j; ++k) {
                        dp[i][j] = min(dp[i][j], dp[i-1][k] + dist - abs(robot[j] - factory[i][0]) + abs(robot[k] - factory[i][0]));
                    }
                }
            }
        }

        return dp[m-1][n-1];
    }
};