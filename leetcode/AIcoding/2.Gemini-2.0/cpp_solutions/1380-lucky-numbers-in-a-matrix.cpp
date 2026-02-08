#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> luckyNumbers (vector<vector<int>>& matrix) {
        vector<int> result;
        int m = matrix.size();
        int n = matrix[0].size();

        for (int i = 0; i < m; ++i) {
            int min_row = matrix[i][0];
            int col_index = 0;
            for (int j = 1; j < n; ++j) {
                if (matrix[i][j] < min_row) {
                    min_row = matrix[i][j];
                    col_index = j;
                }
            }

            bool is_lucky = true;
            for (int k = 0; k < m; ++k) {
                if (matrix[k][col_index] > min_row) {
                    is_lucky = false;
                    break;
                }
            }

            if (is_lucky) {
                result.push_back(min_row);
            }
        }

        return result;
    }
};