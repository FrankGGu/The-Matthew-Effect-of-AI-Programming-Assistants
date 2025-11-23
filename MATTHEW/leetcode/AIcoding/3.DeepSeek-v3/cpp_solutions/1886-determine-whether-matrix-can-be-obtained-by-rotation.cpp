class Solution {
public:
    bool findRotation(vector<vector<int>>& mat, vector<vector<int>>& target) {
        int n = mat.size();
        bool res = true;
        for (int k = 0; k < 4; ++k) {
            res = true;
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (k == 0 && mat[i][j] != target[i][j]) res = false;
                    else if (k == 1 && mat[i][j] != target[j][n - 1 - i]) res = false;
                    else if (k == 2 && mat[i][j] != target[n - 1 - i][n - 1 - j]) res = false;
                    else if (k == 3 && mat[i][j] != target[n - 1 - j][i]) res = false;
                }
            }
            if (res) return true;
        }
        return false;
    }
};