#include <vector>
#include <unordered_set>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> differenceOfDistinctValues(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<int>> result(m, std::vector<int>(n));

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                std::unordered_set<int> distinct1_set;
                int curr_r_tl = r - 1;
                int curr_c_tl = c - 1;
                while (curr_r_tl >= 0 && curr_c_tl >= 0) {
                    distinct1_set.insert(grid[curr_r_tl][curr_c_tl]);
                    curr_r_tl--;
                    curr_c_tl--;
                }
                int distinct1 = distinct1_set.size();

                std::unordered_set<int> distinct2_set;
                int curr_r_br = r + 1;
                int curr_c_br = c + 1;
                while (curr_r_br < m && curr_c_br < n) {
                    distinct2_set.insert(grid[curr_r_br][curr_c_br]);
                    curr_r_br++;
                    curr_c_br++;
                }
                int distinct2 = distinct2_set.size();

                result[r][c] = std::abs(distinct1 - distinct2);
            }
        }

        return result;
    }
};