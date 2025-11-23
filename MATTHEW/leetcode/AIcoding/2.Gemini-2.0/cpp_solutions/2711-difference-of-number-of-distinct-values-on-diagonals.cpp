#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<int>> differenceOfDistinctValues(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> result(m, vector<int>(n));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                unordered_set<int> topLeftDistinct;
                unordered_set<int> bottomRightDistinct;

                int row = i - 1;
                int col = j - 1;
                while (row >= 0 && col >= 0) {
                    topLeftDistinct.insert(grid[row][col]);
                    row--;
                    col--;
                }

                row = i + 1;
                col = j + 1;
                while (row < m && col < n) {
                    bottomRightDistinct.insert(grid[row][col]);
                    row++;
                    col++;
                }

                result[i][j] = abs((int)topLeftDistinct.size() - (int)bottomRightDistinct.size());
            }
        }

        return result;
    }
};