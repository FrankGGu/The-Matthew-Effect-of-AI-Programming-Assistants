#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countSquares(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int count = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (matrix[i][j] == 1) {
                    if (i == 0 || j == 0) {
                        count++;
                    } else {
                        int minVal = min(matrix[i-1][j-1], min(matrix[i-1][j], matrix[i][j-1]));
                        matrix[i][j] += minVal;
                        count += matrix[i][j];
                    }
                }
            }
        }

        return count;
    }
};