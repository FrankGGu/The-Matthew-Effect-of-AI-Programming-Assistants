#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& matrix) {
        if (matrix.empty()) return {};

        int m = matrix.size();
        int n = matrix[0].size();
        vector<int> result(m * n);
        int row = 0, col = 0;
        bool up = true;

        for (int i = 0; i < m * n; ++i) {
            result[i] = matrix[row][col];

            if (up) {
                if (row - 1 >= 0 && col + 1 < n) {
                    row--;
                    col++;
                } else {
                    up = false;
                    if (col + 1 < n) {
                        col++;
                    } else {
                        row++;
                    }
                }
            } else {
                if (row + 1 < m && col - 1 >= 0) {
                    row++;
                    col--;
                } else {
                    up = true;
                    if (row + 1 < m) {
                        row++;
                    } else {
                        col++;
                    }
                }
            }
        }

        return result;
    }
};