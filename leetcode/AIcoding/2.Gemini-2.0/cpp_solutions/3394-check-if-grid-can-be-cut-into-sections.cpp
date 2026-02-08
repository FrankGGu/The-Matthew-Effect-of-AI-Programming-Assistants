#include <vector>

using namespace std;

class Solution {
public:
    bool checkValidGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        if (grid[0][0] != 0) return false;
        vector<pair<int, int>> pos(n * n);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                pos[grid[i][j]] = {i, j};
            }
        }
        for (int i = 1; i < n * n; ++i) {
            int dx = abs(pos[i].first - pos[i - 1].first);
            int dy = abs(pos[i].second - pos[i - 1].second);
            if (dx + dy != 3 || dx == 0 || dy == 0) return false;
        }
        return true;
    }
};