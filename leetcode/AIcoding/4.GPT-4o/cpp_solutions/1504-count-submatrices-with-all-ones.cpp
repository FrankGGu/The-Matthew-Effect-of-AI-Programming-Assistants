class Solution {
public:
    int numSubmat(vector<vector<int>>& mat) {
        int m = mat.size(), n = mat[0].size(), count = 0;
        vector<vector<int>> heights(m, vector<int>(n, 0));

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < m; i++) {
                heights[i][j] = (mat[i][j] == 0) ? 0 : (i == 0 ? 1 : heights[i - 1][j] + 1);
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (mat[i][j] == 1) {
                    int minHeight = heights[i][j];
                    for (int k = j; k >= 0 && mat[i][k] == 1; k--) {
                        minHeight = min(minHeight, heights[i][k]);
                        count += minHeight;
                    }
                }
            }
        }

        return count;
    }
};