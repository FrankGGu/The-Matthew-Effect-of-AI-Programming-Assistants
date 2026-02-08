class Solution {
public:
    vector<vector<int>> incrementSubmatrices(vector<vector<int>>& mat, vector<vector<int>>& indices) {
        int rows = mat.size(), cols = mat[0].size();
        vector<vector<int>> diff(rows + 1, vector<int>(cols + 1, 0));

        for (const auto& index : indices) {
            int r1 = index[0], c1 = index[1];
            diff[r1][c1]++;
            if (r1 + 1 < rows) diff[r1 + 1][c1]--;
            if (c1 + 1 < cols) diff[r1][c1 + 1]--;
            if (r1 + 1 < rows && c1 + 1 < cols) diff[r1 + 1][c1 + 1]++;
        }

        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                if (r > 0) diff[r][c] += diff[r - 1][c];
                if (c > 0) diff[r][c] += diff[r][c - 1];
                if (r > 0 && c > 0) diff[r][c] -= diff[r - 1][c - 1];
                mat[r][c] += diff[r][c];
            }
        }

        return mat;
    }
};