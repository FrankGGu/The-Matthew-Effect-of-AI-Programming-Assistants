class Solution {
public:
    vector<int> findPeakGrid(vector<vector<int>>& mat) {
        int n = mat.size(), m = mat[0].size();
        int left = 0, right = m - 1;

        while (left < right) {
            int mid = left + (right - left) / 2;
            int maxRow = 0;

            for (int i = 1; i < n; ++i) {
                if (mat[i][mid] > mat[maxRow][mid]) {
                    maxRow = i;
                }
            }

            if (mid < m - 1 && mat[maxRow][mid] < mat[maxRow][mid + 1]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        int maxRow = 0;
        for (int i = 1; i < n; ++i) {
            if (mat[i][left] > mat[maxRow][left]) {
                maxRow = i;
            }
        }

        return {maxRow, left};
    }
};