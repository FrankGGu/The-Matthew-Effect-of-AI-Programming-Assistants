class Solution {
public:
    vector<vector<int>> generateSnakeMatrix(int n) {
        vector<vector<int>> matrix(n, vector<int>(n, 0));
        int num = 1;
        for (int layer = 0; layer < (n + 1) / 2; ++layer) {
            for (int i = layer; i < n - layer; ++i) {
                matrix[layer][i] = num++;
            }
            for (int i = layer + 1; i < n - layer; ++i) {
                matrix[i][n - layer - 1] = num++;
            }
            for (int i = n - layer - 1; i >= layer; --i) {
                matrix[n - layer - 1][i] = num++;
            }
            for (int i = n - layer - 2; i > layer; --i) {
                matrix[i][layer] = num++;
            }
        }
        return matrix;
    }
};