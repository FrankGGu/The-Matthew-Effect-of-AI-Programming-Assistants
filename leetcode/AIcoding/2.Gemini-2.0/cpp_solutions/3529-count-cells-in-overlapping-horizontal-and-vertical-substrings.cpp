#include <vector>

using namespace std;

class Solution {
public:
    int countCells(int n, int m, vector<pair<int, int>>& hPositions, vector<pair<int, int>>& vPositions) {
        int count = 0;
        vector<vector<bool>> grid(n, vector<bool>(m, false));

        for (auto& p : hPositions) {
            int x1 = p.first - 1;
            int y1 = p.second - 1;
            int x2 = x1 + 1;

            for (int i = 0; i < m; ++i) {
                grid[x1][i] = true;
            }
        }

        for (auto& p : vPositions) {
            int x1 = p.first - 1;
            int y1 = p.second - 1;
            int y2 = y1 + 1;

            for (int i = 0; i < n; ++i) {
                grid[i][y1] = true;
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j]) {
                    count++;
                }
            }
        }

        return count;
    }
};