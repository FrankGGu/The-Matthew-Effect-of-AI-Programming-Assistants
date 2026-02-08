#include <vector>

class Solution {
public:
    int countServers(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) {
            return 0;
        }
        int n = grid[0].size();
        if (n == 0) {
            return 0;
        }

        std::vector<int> row_counts(m, 0);
        std::vector<int> col_counts(n, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    row_counts[i]++;
                    col_counts[j]++;
                }
            }
        }

        int communicating_servers = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    if (row_counts[i] > 1 || col_counts[j] > 1) {
                        communicating_servers++;
                    }
                }
            }
        }

        return communicating_servers;
    }
};