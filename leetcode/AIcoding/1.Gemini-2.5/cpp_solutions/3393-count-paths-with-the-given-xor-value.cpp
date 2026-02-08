#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPaths(vector<vector<int>>& grid, int x) {
        int m = grid.size();
        int n = grid[0].size();
        int count = 0;

        function<void(int, int, int)> dfs = [&](int row, int col, int currentXor) {
            if (row == m || col == n) {
                return;
            }

            currentXor ^= grid[row][col];

            if (row == m - 1 && col == n - 1) {
                if (currentXor == x) {
                    count++;
                }
                return;
            }

            dfs(row + 1, col, currentXor);
            dfs(row, col + 1, currentXor);
        };

        dfs(0, 0, 0);
        return count;
    }
};