#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumRows(vector<vector<int>>& matrix, int cols) {
        int m = matrix.size();
        int n = matrix[0].size();
        int max_rows = 0;

        for (int i = 0; i < (1 << n); ++i) {
            if (__builtin_popcount(i) != cols) continue;

            vector<int> selected_cols;
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    selected_cols.push_back(j);
                }
            }

            int covered_rows = 0;
            for (int row = 0; row < m; ++row) {
                bool covered = true;
                for (int col = 0; col < n; ++col) {
                    if (matrix[row][col] == 1) {
                        bool found = false;
                        for (int selected_col : selected_cols) {
                            if (col == selected_col) {
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            covered = false;
                            break;
                        }
                    }
                }
                if (covered) {
                    covered_rows++;
                }
            }
            max_rows = max(max_rows, covered_rows);
        }

        return max_rows;
    }
};