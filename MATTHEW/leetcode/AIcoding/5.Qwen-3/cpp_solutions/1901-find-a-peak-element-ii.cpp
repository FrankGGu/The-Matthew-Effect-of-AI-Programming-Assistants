#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findPeakII(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();

        int left = 0;
        int right = cols - 1;

        while (left <= right) {
            int midCol = left + (right - left) / 2;
            int maxRow = 0;

            for (int i = 1; i < rows; ++i) {
                if (matrix[i][midCol] > matrix[maxRow][midCol]) {
                    maxRow = i;
                }
            }

            if (matrix[maxRow][midCol] > matrix[maxRow][midCol - 1] && matrix[maxRow][midCol] > matrix[maxRow][midCol + 1]) {
                return matrix[maxRow][midCol];
            } else if (matrix[maxRow][midCol] < matrix[maxRow][midCol - 1]) {
                right = midCol - 1;
            } else {
                left = midCol + 1;
            }
        }

        return -1;
    }
};