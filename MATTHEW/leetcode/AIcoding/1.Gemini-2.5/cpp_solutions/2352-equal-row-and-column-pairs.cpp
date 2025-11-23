#include <vector>
#include <map>

class Solution {
public:
    int equalPairs(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        std::map<std::vector<int>, int> row_counts;

        for (const auto& row : grid) {
            row_counts[row]++;
        }

        int count = 0;
        for (int j = 0; j < n; ++j) {
            std::vector<int> col_vec;
            for (int i = 0; i < n; ++i) {
                col_vec.push_back(grid[i][j]);
            }
            if (row_counts.count(col_vec)) {
                count += row_counts[col_vec];
            }
        }

        return count;
    }
};