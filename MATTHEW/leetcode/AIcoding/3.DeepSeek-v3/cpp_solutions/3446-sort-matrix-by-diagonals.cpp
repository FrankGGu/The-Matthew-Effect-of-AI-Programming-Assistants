class Solution {
public:
    vector<vector<int>> diagonalSort(vector<vector<int>>& mat) {
        int m = mat.size();
        if (m == 0) return mat;
        int n = mat[0].size();

        for (int d = 0; d < m + n - 1; ++d) {
            vector<int> diagonal;
            int i = max(0, m - 1 - d);
            int j = max(0, d - (m - 1));
            while (i < m && j < n) {
                diagonal.push_back(mat[i][j]);
                ++i;
                ++j;
            }
            sort(diagonal.begin(), diagonal.end());
            i = max(0, m - 1 - d);
            j = max(0, d - (m - 1));
            int k = 0;
            while (i < m && j < n) {
                mat[i][j] = diagonal[k++];
                ++i;
                ++j;
            }
        }
        return mat;
    }
};