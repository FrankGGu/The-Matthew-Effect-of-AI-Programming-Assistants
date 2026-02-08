class Solution {
public:
    vector<vector<int>> createNewColumn(vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return matrix;
        int m = matrix.size();
        int n = matrix[0].size();
        for (int i = 0; i < m; ++i) {
            int sum = 0;
            for (int j = 0; j < n; ++j) {
                sum += matrix[i][j];
            }
            matrix[i].push_back(sum);
        }
        return matrix;
    }
};