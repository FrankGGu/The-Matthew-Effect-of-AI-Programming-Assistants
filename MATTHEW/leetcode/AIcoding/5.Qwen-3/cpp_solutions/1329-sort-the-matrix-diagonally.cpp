#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> diagonalSort(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        vector<vector<int>> result(m, vector<int>(n));

        for (int i = 0; i < m; ++i) {
            int row = i;
            int col = 0;
            vector<int> diag;
            while (row < m && col < n) {
                diag.push_back(matrix[row][col]);
                ++row;
                ++col;
            }
            sort(diag.begin(), diag.end());
            row = i;
            col = 0;
            int idx = 0;
            while (row < m && col < n) {
                result[row][col] = diag[idx++];
                ++row;
                ++col;
            }
        }

        for (int j = 1; j < n; ++j) {
            int row = 0;
            int col = j;
            vector<int> diag;
            while (row < m && col < n) {
                diag.push_back(matrix[row][col]);
                ++row;
                ++col;
            }
            sort(diag.begin(), diag.end());
            row = 0;
            col = j;
            int idx = 0;
            while (row < m && col < n) {
                result[row][col] = diag[idx++];
                ++row;
                ++col;
            }
        }

        return result;
    }
};