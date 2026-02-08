#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findBall(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<int> ans(n);

        for (int i = 0; i < n; ++i) {
            int col = i;
            int row = 0;
            while (row < m) {
                int next_col = col + grid[row][col];
                if (next_col < 0 || next_col >= n || grid[row][col] != grid[row][next_col]) {
                    ans[i] = -1;
                    break;
                }
                col = next_col;
                row++;
            }
            if (row == m) {
                ans[i] = col;
            }
        }
        return ans;
    }
};