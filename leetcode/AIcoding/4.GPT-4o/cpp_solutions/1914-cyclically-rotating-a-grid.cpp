class Solution {
public:
    vector<vector<int>> rotateGrid(vector<vector<int>>& grid, int k) {
        int rows = grid.size(), cols = grid[0].size();
        vector<vector<int>> result = grid;
        int layers = min(rows, cols) / 2;

        for (int layer = 0; layer < layers; ++layer) {
            int perimeter = 2 * (rows + cols - 4 * layer) - 4;
            int effective_k = k % perimeter;

            vector<int> temp;
            for (int j = layer; j < cols - layer; ++j) temp.push_back(grid[layer][j]);
            for (int i = layer + 1; i < rows - layer; ++i) temp.push_back(grid[i][cols - layer - 1]);
            for (int j = cols - layer - 1; j >= layer; --j) temp.push_back(grid[rows - layer - 1][j]);
            for (int i = rows - layer - 2; i > layer; --i) temp.push_back(grid[i][layer]);

            int n = temp.size();
            for (int i = 0; i < n; ++i) {
                result[layer + (i + effective_k) % n / (cols - 2 * layer)][layer + (i + effective_k) % n % (cols - 2 * layer)] = temp[i];
            }
        }
        return result;
    }
};