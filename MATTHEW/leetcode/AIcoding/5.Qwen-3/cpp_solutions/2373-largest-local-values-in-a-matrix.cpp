#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> largestLocal(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> result(n - 1, vector<int>(n - 1));

        for (int i = 0; i < n - 1; ++i) {
            for (int j = 0; j < n - 1; ++j) {
                int maxVal = 0;
                for (int x = i; x < i + 2; ++x) {
                    for (int y = j; y < j + 2; ++y) {
                        maxVal = max(maxVal, grid[x][y]);
                    }
                }
                result[i][j] = maxVal;
            }
        }

        return result;
    }
};