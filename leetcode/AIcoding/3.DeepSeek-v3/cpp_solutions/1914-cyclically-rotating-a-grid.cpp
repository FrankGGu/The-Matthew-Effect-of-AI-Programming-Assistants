class Solution {
public:
    vector<vector<int>> rotateGrid(vector<vector<int>>& grid, int k) {
        int m = grid.size(), n = grid[0].size();
        int layers = min(m, n) / 2;

        for (int l = 0; l < layers; ++l) {
            vector<int> elements;
            int top = l, bottom = m - 1 - l;
            int left = l, right = n - 1 - l;

            for (int i = left; i < right; ++i) elements.push_back(grid[top][i]);
            for (int i = top; i < bottom; ++i) elements.push_back(grid[i][right]);
            for (int i = right; i > left; --i) elements.push_back(grid[bottom][i]);
            for (int i = bottom; i > top; --i) elements.push_back(grid[i][left]);

            int total = elements.size();
            int shift = k % total;

            rotate(elements.begin(), elements.begin() + shift, elements.end());

            int idx = 0;
            for (int i = left; i < right; ++i) grid[top][i] = elements[idx++];
            for (int i = top; i < bottom; ++i) grid[i][right] = elements[idx++];
            for (int i = right; i > left; --i) grid[bottom][i] = elements[idx++];
            for (int i = bottom; i > top; --i) grid[i][left] = elements[idx++];
        }

        return grid;
    }
};