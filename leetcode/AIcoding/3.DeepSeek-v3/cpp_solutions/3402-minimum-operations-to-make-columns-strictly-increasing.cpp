#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        int res = 0;
        for (int j = 0; j < n; ++j) {
            vector<int> col;
            for (int i = 0; i < m; ++i) {
                col.push_back(grid[i][j]);
            }
            sort(col.begin(), col.end());
            for (int i = 1; i < m; ++i) {
                if (col[i] <= col[i-1]) {
                    res += col[i-1] + 1 - col[i];
                    col[i] = col[i-1] + 1;
                }
            }
        }
        return res;
    }
};