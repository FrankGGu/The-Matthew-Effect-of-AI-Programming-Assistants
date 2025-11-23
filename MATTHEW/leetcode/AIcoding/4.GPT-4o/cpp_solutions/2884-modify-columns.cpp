class Solution {
public:
    vector<vector<int>> modifyColumns(vector<vector<int>>& mat) {
        int m = mat.size(), n = mat[0].size();
        for (int j = 0; j < n; ++j) {
            vector<int> col;
            for (int i = 0; i < m; ++i) {
                col.push_back(mat[i][j]);
            }
            sort(col.begin(), col.end());
            for (int i = 0; i < m; ++i) {
                mat[i][j] = col[i];
            }
        }
        return mat;
    }
};