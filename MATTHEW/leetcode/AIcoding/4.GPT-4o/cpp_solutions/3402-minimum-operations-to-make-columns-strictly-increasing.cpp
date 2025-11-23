#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<int> prev(n, 0);
        int operations = 0;

        for (int j = 0; j < n; ++j) {
            vector<int> col(m);
            for (int i = 0; i < m; ++i) {
                col[i] = grid[i][j];
            }
            sort(col.begin(), col.end());
            for (int i = 0; i < m; ++i) {
                int required = col[i] + i;
                if (j > 0) {
                    required = max(required, prev[i] + 1);
                }
                operations += max(0, required - col[i]);
                prev[i] = required;
            }
        }
        return operations;
    }
};