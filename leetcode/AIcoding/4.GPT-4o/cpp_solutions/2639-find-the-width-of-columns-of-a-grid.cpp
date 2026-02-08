#include <vector>
#include <string>
#include <algorithm>

using namespace std;

vector<int> findColumnWidth(vector<vector<string>>& grid) {
    int m = grid.size(), n = grid[0].size();
    vector<int> widths(n, 0);

    for (int j = 0; j < n; ++j) {
        for (int i = 0; i < m; ++i) {
            widths[j] = max(widths[j], (int)grid[i][j].size());
        }
    }

    return widths;
}