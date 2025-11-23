#include <iostream>
#include <vector>
#include <cmath>
#include <climits>

using namespace std;

class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n, -1)));
        return max(0, dfs(grid, 0, 0, 0, dp));
    }

    int dfs(vector<vector<int>>& grid, int x1, int y1, int x2, vector<vector<vector<int>>>& dp) {
        int n = grid.size();
        int y2 = x1 + y1 - x2;
        if (x1 >= n || y1 >= n || x2 >= n || y2 >= n) return -1;
        if (grid[x1][y1] == -1 || grid[x2][y2] == -1) return -1;
        if (x1 == n - 1 && y1 == n - 1) return grid[x1][y1];
        if (dp[x1][y1][x2] != -1) return dp[x1][y1][x2];

        int res = 0;
        if (x1 == x2 && y1 == y2) {
            res += grid[x1][y1];
        } else {
            res += grid[x1][y1] + grid[x2][y2];
        }

        int maxCherries = -1;
        for (int dx = 0; dx <= 1; ++dx) {
            for (int dy = 0; dy <= 1; ++dy) {
                int nextX1 = x1 + dx;
                int nextY1 = y1 + dy;
                int nextX2 = x2 + dx;
                int nextY2 = y2 + dy;
                int temp = dfs(grid, nextX1, nextY1, nextX2, dp);
                if (temp != -1) {
                    maxCherries = max(maxCherries, temp);
                }
            }
        }

        if (maxCherries == -1) {
            dp[x1][y1][x2] = -1;
        } else {
            dp[x1][y1][x2] = res + maxCherries;
        }

        return dp[x1][y1][x2];
    }
};