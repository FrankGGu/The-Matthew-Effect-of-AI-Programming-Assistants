class Solution {
public:
    vector<int> findPeakGrid(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        int low = 0, high = m - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int max_col = 0;
            for (int j = 1; j < n; ++j) {
                if (mat[mid][j] > mat[mid][max_col]) {
                    max_col = j;
                }
            }
            bool isPeak = true;
            if (mid > 0 && mat[mid][max_col] < mat[mid - 1][max_col]) {
                isPeak = false;
                high = mid - 1;
            } else if (mid < m - 1 && mat[mid][max_col] < mat[mid + 1][max_col]) {
                isPeak = false;
                low = mid + 1;
            }
            if (isPeak) {
                return {mid, max_col};
            }
        }
        return {-1, -1};
    }
};