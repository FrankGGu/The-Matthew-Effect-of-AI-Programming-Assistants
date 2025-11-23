#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> diagonalSort(std::vector<std::vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();

        // Iterate through diagonals starting from the first row (j from 0 to n-1)
        for (int j = 0; j < n; ++j) {
            std::vector<int> diagonal_elements;
            int r = 0;
            int c = j;

            // Collect elements of the current diagonal
            while (r < m && c < n) {
                diagonal_elements.push_back(mat[r][c]);
                r++;
                c++;
            }

            // Sort the collected elements
            std::sort(diagonal_elements.begin(), diagonal_elements.end());

            // Put the sorted elements back into the matrix along the same diagonal
            r = 0;
            c = j;
            int idx = 0;
            while (r < m && c < n) {
                mat[r][c] = diagonal_elements[idx];
                r++;
                c++;
                idx++;
            }
        }

        // Iterate through diagonals starting from the first column (i from 1 to m-1)
        // The diagonal starting at (0,0) is already handled by the first loop (when j=0).
        for (int i = 1; i < m; ++i) {
            std::vector<int> diagonal_elements;
            int r = i;
            int c = 0;

            // Collect elements of the current diagonal
            while (r < m && c < n) {
                diagonal_elements.push_back(mat[r][c]);
                r++;
                c++;
            }

            // Sort the collected elements
            std::sort(diagonal_elements.begin(), diagonal_elements.end());

            // Put the sorted elements back into the matrix along the same diagonal
            r = i;
            c = 0;
            int idx = 0;
            while (r < m && c < n) {
                mat[r][c] = diagonal_elements[idx];
                r++;
                c++;
                idx++;
            }
        }

        return mat;
    }
};