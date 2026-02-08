class Solution {
public:
    bool checkValid(vector<vector<int>>& matrix) {
        int n = matrix.size();
        for (int i = 0; i < n; ++i) {
            unordered_set<int> row, col;
            for (int j = 0; j < n; ++j) {
                if (row.count(matrix[i][j]) || matrix[i][j] < 1 || matrix[i][j] > n) {
                    return false;
                }
                row.insert(matrix[i][j]);

                if (col.count(matrix[j][i]) || matrix[j][i] < 1 || matrix[j][i] > n) {
                    return false;
                }
                col.insert(matrix[j][i]);
            }
        }
        return true;
    }
};