#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTotalDistance(vector<vector<int>>& grid) {
        vector<int> rows;
        vector<int> cols;

        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[0].size(); ++j) {
                if (grid[i][j] == 1) {
                    rows.push_back(i);
                    cols.push_back(j);
                }
            }
        }

        sort(cols.begin(), cols.end());

        int row_median = rows[rows.size() / 2];
        int col_median = cols[cols.size() / 2];

        int total_distance = 0;
        for (int row : rows) {
            total_distance += abs(row - row_median);
        }
        for (int col : cols) {
            total_distance += abs(col - col_median);
        }

        return total_distance;
    }
};