#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> modifiedMatrix(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        vector<int> max_in_col(n, -1);
        for (int j = 0; j < n; ++j) {
            for (int i = 0; i < m; ++i) {
                max_in_col[j] = max(max_in_col[j], matrix[i][j]);
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == -1) {
                    matrix[i][j] = max_in_col[j];
                }
            }
        }

        return matrix;
    }
};