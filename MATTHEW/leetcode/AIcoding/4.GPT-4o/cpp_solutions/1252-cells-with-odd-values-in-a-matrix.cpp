class Solution {
public:
    int oddCells(int m, int n, vector<vector<int>>& indices) {
        vector<vector<int>> matrix(m, vector<int>(n, 0));
        for (const auto& index : indices) {
            for (int j = 0; j < n; ++j) {
                matrix[index[0]][j]++;
            }
            for (int i = 0; i < m; ++i) {
                matrix[i][index[1]]++;
            }
        }
        int count = 0;
        for (const auto& row : matrix) {
            for (int val : row) {
                if (val % 2 != 0) {
                    count++;
                }
            }
        }
        return count;
    }
};