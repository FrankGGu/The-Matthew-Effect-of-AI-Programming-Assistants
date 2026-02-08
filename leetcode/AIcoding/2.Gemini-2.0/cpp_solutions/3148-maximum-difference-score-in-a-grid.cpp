#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDiff(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int maxVal = grid[0][0];
        int minVal = grid[0][0];
        int ans = -1;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] > maxVal) {
                    maxVal = grid[i][j];
                    ans = max(ans, maxVal - minVal);
                } else if (grid[i][j] < minVal) {
                    minVal = grid[i][j];
                    maxVal = grid[i][j];
                } else if (grid[i][j] > minVal){
                    ans = max(ans, grid[i][j] - minVal);
                }
            }
        }

        return ans;
    }
};