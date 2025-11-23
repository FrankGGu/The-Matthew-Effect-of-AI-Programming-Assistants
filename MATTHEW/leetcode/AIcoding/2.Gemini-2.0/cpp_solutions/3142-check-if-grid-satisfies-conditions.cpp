#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool checkValidGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        if (grid[0][0] != 0) {
            return false;
        }

        vector<pair<int, int>> pos(n * n);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                pos[grid[i][j]] = {i, j};
            }
        }

        for (int i = 1; i < n * n; ++i) {
            int rowDiff = abs(pos[i].first - pos[i - 1].first);
            int colDiff = abs(pos[i].second - pos[i - 1].second);
            if (rowDiff * rowDiff + colDiff * colDiff != 5) {
                return false;
            }
            if(rowDiff != 1 && rowDiff != 2) return false;
            if(colDiff != 1 && colDiff != 2) return false;

            if(rowDiff == colDiff) return false;
        }

        return true;
    }
};