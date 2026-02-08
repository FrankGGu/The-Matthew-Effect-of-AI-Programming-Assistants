#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int maxIncreasingCells(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        map<int, vector<pair<int, int>>> valToCells;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                valToCells[mat[i][j]].push_back({i, j});
            }
        }

        vector<int> rowMax(m, 0);
        vector<int> colMax(n, 0);
        int ans = 0;

        for (auto it = valToCells.begin(); it != valToCells.end(); ++it) {
            vector<pair<int, int>> cells = it->second;
            vector<int> temp(cells.size());
            for (int i = 0; i < cells.size(); ++i) {
                int r = cells[i].first;
                int c = cells[i].second;
                temp[i] = max(rowMax[r], colMax[c]) + 1;
            }
            for (int i = 0; i < cells.size(); ++i) {
                int r = cells[i].first;
                int c = cells[i].second;
                rowMax[r] = max(rowMax[r], temp[i]);
                colMax[c] = max(colMax[c], temp[i]);
                ans = max(ans, temp[i]);
            }
        }

        return ans;
    }
};