#include <vector>

using namespace std;

class Solution {
public:
    bool checkValidGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        if (grid[0][0] != 0) return false;

        vector<pair<int, int>> positions(n * n);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                positions[grid[i][j]] = {i, j};
            }
        }

        for (int i = 1; i < n * n; ++i) {
            int x1 = positions[i - 1].first;
            int y1 = positions[i - 1].second;
            int x2 = positions[i].first;
            int y2 = positions[i].second;

            int dx = abs(x1 - x2);
            int dy = abs(y1 - y2);

            if ((dx == 2 && dy == 1) || (dx == 1 && dy == 2)) {
                continue;
            } else {
                return false;
            }
        }

        return true;
    }
};