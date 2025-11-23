#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> rotateGrid(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        int layers = min(m, n) / 2;

        for (int l = 0; l < layers; ++l) {
            int perimeter = 2 * (m - 2 * l) + 2 * (n - 2 * l) - 4;
            int rotations = k % perimeter;

            for (int r = 0; r < rotations; ++r) {
                int temp = grid[l][l];

                // Move elements from left to top
                for (int j = l; j < n - l - 1; ++j) {
                    grid[l][j] = grid[l][j + 1];
                }

                // Move elements from top to right
                for (int i = l; i < m - l - 1; ++i) {
                    grid[i][n - l - 1] = grid[i + 1][n - l - 1];
                }

                // Move elements from right to bottom
                for (int j = n - l - 1; j > l; --j) {
                    grid[m - l - 1][j] = grid[m - l - 1][j - 1];
                }

                // Move elements from bottom to left
                for (int i = m - l - 1; i > l + 1; --i) {
                    grid[i][l] = grid[i - 1][l];
                }

                grid[l + 1][l] = temp;
            }
        }

        return grid;
    }
};