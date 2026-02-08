class Solution {
public:
    vector<int> findPeakGrid(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        int low = 0, high = m - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int max_col = 0;
            for (int i = 1; i < n; ++i) {
                if (mat[mid][i] > mat[mid][max_col]) {
                    max_col = i;
                }
            }
            if (mid > 0 && mat[mid][max_col] < mat[mid - 1][max_col]) {
                high = mid - 1;
            } else if (mid < m - 1 && mat[mid][max_col] < mat[mid + 1][max_col]) {
                low = mid + 1;
            } else {
                return {mid, max_col};
            }
        }
        return {-1, -1};
    }
};