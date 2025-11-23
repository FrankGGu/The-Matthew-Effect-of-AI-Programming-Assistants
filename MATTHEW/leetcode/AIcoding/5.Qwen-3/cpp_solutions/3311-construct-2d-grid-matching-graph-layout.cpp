#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> construct2DGrid(vector<vector<int>>& rows, vector<vector<int>>& cols) {
        int m = rows.size();
        int n = cols.size();
        vector<vector<int>> grid(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                grid[i][j] = rows[i][j] * 1000 + cols[j][i];
            }
        }

        return grid;
    }
};