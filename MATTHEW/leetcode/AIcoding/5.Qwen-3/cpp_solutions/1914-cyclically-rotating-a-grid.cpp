#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> rotateGrid(const std::vector<std::vector<int>>& grid, int k) {
        int rows = grid.size();
        int cols = grid[0].size();
        std::vector<std::vector<int>> result = grid;

        int minDim = std::min(rows, cols);
        for (int layer = 0; layer < minDim / 2; ++layer) {
            int top = layer;
            int bottom = rows - 1 - layer;
            int left = layer;
            int right = cols - 1 - layer;

            std::vector<int> temp;
            for (int i = left; i <= right; ++i) {
                temp.push_back(result[top][i]);
            }
            for (int i = top + 1; i <= bottom; ++i) {
                temp.push_back(result[i][right]);
            }
            for (int i = right - 1; i >= left; --i) {
                temp.push_back(result[bottom][i]);
            }
            for (int i = bottom - 1; i > top; --i) {
                temp.push_back(result[i][left]);
            }

            int n = temp.size();
            k %= n;
            if (k == 0) continue;

            int idx = 0;
            for (int i = left; i <= right; ++i) {
                result[top][i] = temp[(idx + k) % n];
                ++idx;
            }
            for (int i = top + 1; i <= bottom; ++i) {
                result[i][right] = temp[(idx + k) % n];
                ++idx;
            }
            for (int i = right - 1; i >= left; --i) {
                result[bottom][i] = temp[(idx + k) % n];
                ++idx;
            }
            for (int i = bottom - 1; i > top; --i) {
                result[i][left] = temp[(idx + k) % n];
                ++idx;
            }
        }

        return result;
    }
};