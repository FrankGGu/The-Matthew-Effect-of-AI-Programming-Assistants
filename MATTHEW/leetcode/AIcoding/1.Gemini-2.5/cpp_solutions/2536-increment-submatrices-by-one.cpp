#include <vector>
#include <iostream>

class Solution {
public:
    std::vector<std::vector<int>> rangeAddQueries(int n, std::vector<std::vector<int>>& queries) {
        std::vector<std::vector<int>> mat(n, std::vector<int>(n, 0));

        for (const auto& query : queries) {
            int row1 = query[0];
            int col1 = query[1];
            int row2 = query[2];
            int col2 = query[3];

            mat[row1][col1]++;

            if (col2 + 1 < n) {
                mat[row1][col2 + 1]--;
            }

            if (row2 + 1 < n) {
                mat[row2 + 1][col1]--;
            }

            if (row2 + 1 < n && col2 + 1 < n) {
                mat[row2 + 1][col2 + 1]++;
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 1; j < n; ++j) {
                mat[i][j] += mat[i][j - 1];
            }
        }

        for (int j = 0; j < n; ++j) {
            for (int i = 1; i < n; ++i) {
                mat[i][j] += mat[i - 1][j];
            }
        }

        return mat;
    }
};