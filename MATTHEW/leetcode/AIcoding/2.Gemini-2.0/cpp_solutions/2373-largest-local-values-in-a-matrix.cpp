#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> largestLocal(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = n - 2;
        vector<vector<int>> maxLocal(m, vector<int>(m));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < m; ++j) {
                int maxVal = 0;
                for (int row = i; row < i + 3; ++row) {
                    for (int col = j; col < j + 3; ++col) {
                        maxVal = max(maxVal, grid[row][col]);
                    }
                }
                maxLocal[i][j] = maxVal;
            }
        }

        return maxLocal;
    }
};