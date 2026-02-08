#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> rotateGrid(std::vector<std::vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();

        int r1 = 0, c1 = 0;
        int r2 = m - 1, c2 = n - 1;

        while (r1 < r2 && c1 < c2) {
            std::vector<int> layer_elements;

            for (int c = c1; c <= c2; ++c) {
                layer_elements.push_back(grid[r1][c]);
            }
            for (int r = r1 + 1; r <= r2; ++r) {
                layer_elements.push_back(grid[r][c2]);
            }
            for (int c = c2 - 1; c >= c1; --c) {
                layer_elements.push_back(grid[r2][c]);
            }
            for (int r = r2 - 1; r >= r1 + 1; --r) {
                layer_elements.push_back(grid[r][c1]);
            }

            int layer_size = layer_elements.size();
            int effective_k = k % layer_size;

            std::rotate(layer_elements.begin(), layer_elements.begin() + effective_k, layer_elements.end());

            int idx = 0;
            for (int c = c1; c <= c2; ++c) {
                grid[r1][c] = layer_elements[idx++];
            }
            for (int r = r1 + 1; r <= r2; ++r) {
                grid[r][c2] = layer_elements[idx++];
            }
            for (int c = c2 - 1; c >= c1; --c) {
                grid[r2][c] = layer_elements[idx++];
            }
            for (int r = r2 - 1; r >= r1 + 1; --r) {
                grid[r][c1] = layer_elements[idx++];
            }

            r1++;
            c1++;
            r2--;
            c2--;
        }

        return grid;
    }
};