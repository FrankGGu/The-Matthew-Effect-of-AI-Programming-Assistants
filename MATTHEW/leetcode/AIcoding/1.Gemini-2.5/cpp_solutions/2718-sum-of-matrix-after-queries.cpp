#include <vector>

class Solution {
public:
    long long matrixSumQueries(int n, std::vector<std::vector<int>>& queries) {
        long long total_sum = 0;

        std::vector<bool> row_covered(n, false);
        std::vector<bool> col_covered(n, false);

        int covered_rows_count = 0;
        int covered_cols_count = 0;

        for (int i = queries.size() - 1; i >= 0; --i) {
            int type = queries[i][0];
            int index = queries[i][1];
            int val = queries[i][2];

            if (type == 0) {
                if (!row_covered[index]) {
                    total_sum += (long long)val * (n - covered_cols_count);
                    row_covered[index] = true;
                    covered_rows_count++;
                }
            } else {
                if (!col_covered[index]) {
                    total_sum += (long long)val * (n - covered_rows_count);
                    col_covered[index] = true;
                    covered_cols_count++;
                }
            }

            if (covered_rows_count == n && covered_cols_count == n) {
                break;
            }
        }

        return total_sum;
    }
};