class Solution {
public:
    int firstCompleteIndex(vector<int>& arr, vector<vector<int>>& mat) {
        int n = mat.size(), m = mat[0].size();
        vector<int> row(n, 0), col(m, 0);
        unordered_map<int, pair<int, int>> pos;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                pos[mat[i][j]] = {i, j};
            }
        }

        for (int i = 0; i < arr.size(); ++i) {
            auto [r, c] = pos[arr[i]];
            row[r]++;
            col[c]++;
            if (row[r] == m || col[c] == n) {
                return i;
            }
        }

        return -1;
    }
};