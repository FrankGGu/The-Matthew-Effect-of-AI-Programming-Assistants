#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numSpecial(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        vector<int> rowSum(rows, 0);
        vector<int> colSum(cols, 0);

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                rowSum[i] += matrix[i][j];
                colSum[j] += matrix[i][j];
            }
        }

        int count = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (matrix[i][j] == 1 && rowSum[i] == 1 && colSum[j] == 1) {
                    ++count;
                }
            }
        }

        return count;
    }
};