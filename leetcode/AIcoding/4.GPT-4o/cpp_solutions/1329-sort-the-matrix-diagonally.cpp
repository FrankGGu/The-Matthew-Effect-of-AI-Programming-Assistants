class Solution {
public:
    vector<vector<int>> diagonalSort(vector<vector<int>>& mat) {
        int m = mat.size(), n = mat[0].size();
        unordered_map<int, vector<int>> diagonals;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                diagonals[i - j].push_back(mat[i][j]);
            }
        }

        for (auto& diag : diagonals) {
            sort(diag.second.begin(), diag.second.end());
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                mat[i][j] = diagonals[i - j].back();
                diagonals[i - j].pop_back();
            }
        }

        return mat;
    }
};