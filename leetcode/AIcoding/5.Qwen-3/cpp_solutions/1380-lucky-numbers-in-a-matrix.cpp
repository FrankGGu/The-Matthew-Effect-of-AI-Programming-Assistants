#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> luckyNumbers (vector<vector<int>>& matrix) {
        vector<int> result;
        int rows = matrix.size();
        int cols = matrix[0].size();

        vector<int> minInRow(rows, INT_MAX);
        vector<int> maxInCol(cols, INT_MIN);

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                minInRow[i] = min(minInRow[i], matrix[i][j]);
                maxInCol[j] = max(maxInCol[j], matrix[i][j]);
            }
        }

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (matrix[i][j] == minInRow[i] && matrix[i][j] == maxInCol[j]) {
                    result.push_back(matrix[i][j]);
                }
            }
        }

        return result;
    }
};