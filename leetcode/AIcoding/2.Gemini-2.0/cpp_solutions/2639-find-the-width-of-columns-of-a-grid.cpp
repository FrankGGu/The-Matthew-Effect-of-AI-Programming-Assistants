#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findColumnWidth(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<int> result(n, 0);

        for (int j = 0; j < n; ++j) {
            int max_width = 0;
            for (int i = 0; i < m; ++i) {
                string s = to_string(grid[i][j]);
                max_width = max(max_width, (int)s.length());
            }
            result[j] = max_width;
        }

        return result;
    }
};