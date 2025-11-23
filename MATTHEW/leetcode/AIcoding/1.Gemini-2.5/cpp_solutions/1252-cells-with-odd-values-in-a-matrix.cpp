#include <vector>
#include <numeric>

class Solution {
public:
    int oddCells(int m, int n, std::vector<std::vector<int>>& indices) {
        std::vector<int> row_counts(m, 0);
        std::vector<int> col_counts(n, 0);

        for (const auto& index : indices) {
            row_counts[index[0]]++;
            col_counts[index[1]]++;
        }

        int odd_rows = 0;
        for (int count : row_counts) {
            if (count % 2 != 0) {
                odd_rows++;
            }
        }

        int odd_cols = 0;
        for (int count : col_counts) {
            if (count % 2 != 0) {
                odd_cols++;
            }
        }

        int even_rows = m - odd_rows;
        int even_cols = n - odd_cols;

        return odd_rows * even_cols + even_rows * odd_cols;
    }
};