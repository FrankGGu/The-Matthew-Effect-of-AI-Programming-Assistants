class Solution {
public:
    vector<vector<int>> generateMatrix(int n) {
        vector<vector<int>> matrix(n, vector<int>(n));
        int num = 1;
        int top = 0;
        int bottom = n - 1;
        int left = 0;
        int right = n - 1;

        while (num <= n * n) {
            // Traverse right
            for (int j = left; j <= right; ++j) {
                matrix[top][j] = num++;
            }
            top++;

            // Traverse down
            for (int i = top; i <= bottom; ++i) {
                matrix[i][right] = num++;
            }
            right--;

            // Traverse left
            if (top <= bottom) {
                for (int j = right; j >= left; --j) {
                    matrix[bottom][j] = num++;
                }
                bottom--;
            }

            // Traverse up
            if (left <= right) {
                for (int i = bottom; i >= top; --i) {
                    matrix[i][left] = num++;
                }
                left++;
            }
        }
        return matrix;
    }
};