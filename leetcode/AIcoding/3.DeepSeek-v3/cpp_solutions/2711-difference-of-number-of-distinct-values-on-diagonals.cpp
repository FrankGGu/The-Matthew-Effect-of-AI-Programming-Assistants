#include <vector>
#include <unordered_set>
#include <cmath>
using namespace std;

class Solution {
public:
    vector<vector<int>> differenceOfDistinctValues(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> ans(m, vector<int>(n, 0));

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                unordered_set<int> topLeft;
                int r = i - 1, c = j - 1;
                while (r >= 0 && c >= 0) {
                    topLeft.insert(grid[r][c]);
                    r--;
                    c--;
                }

                unordered_set<int> bottomRight;
                r = i + 1;
                c = j + 1;
                while (r < m && c < n) {
                    bottomRight.insert(grid[r][c]);
                    r++;
                    c++;
                }

                int topLeftCount = topLeft.size();
                int bottomRightCount = bottomRight.size();
                ans[i][j] = abs(topLeftCount - bottomRightCount);
            }
        }

        return ans;
    }
};