class Solution {
public:
    bool checkValid(vector<vector<int>>& matrix) {
        int n = matrix.size();
        vector<int> rowCheck(n, 0), colCheck(n, 0);

        for (int i = 0; i < n; ++i) {
            fill(rowCheck.begin(), rowCheck.end(), 0);
            fill(colCheck.begin(), colCheck.end(), 0);
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] < 1 || matrix[i][j] > n || rowCheck[matrix[i][j] - 1]) return false;
                if (matrix[j][i] < 1 || matrix[j][i] > n || colCheck[matrix[j][i] - 1]) return false;
                rowCheck[matrix[i][j] - 1] = 1;
                colCheck[matrix[j][i] - 1] = 1;
            }
        }
        return true;
    }
};