class Solution {
public:
    vector<vector<int>> diagonalSort(vector<vector<int>>& mat) {
        int m = mat.size();
        if (m == 0) return mat;
        int n = mat[0].size();

        for (int i = 0; i < m; ++i) {
            vector<int> diagonal;
            int x = i, y = 0;
            while (x < m && y < n) {
                diagonal.push_back(mat[x][y]);
                ++x;
                ++y;
            }
            sort(diagonal.begin(), diagonal.end());
            x = i, y = 0;
            int k = 0;
            while (x < m && y < n) {
                mat[x][y] = diagonal[k++];
                ++x;
                ++y;
            }
        }

        for (int j = 1; j < n; ++j) {
            vector<int> diagonal;
            int x = 0, y = j;
            while (x < m && y < n) {
                diagonal.push_back(mat[x][y]);
                ++x;
                ++y;
            }
            sort(diagonal.begin(), diagonal.end());
            x = 0, y = j;
            int k = 0;
            while (x < m && y < n) {
                mat[x][y] = diagonal[k++];
                ++x;
                ++y;
            }
        }

        return mat;
    }
};