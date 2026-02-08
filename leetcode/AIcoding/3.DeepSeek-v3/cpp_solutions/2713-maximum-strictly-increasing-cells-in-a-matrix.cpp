class Solution {
public:
    int maxIncreasingCells(vector<vector<int>>& mat) {
        int m = mat.size();
        if (m == 0) return 0;
        int n = mat[0].size();
        if (n == 0) return 0;

        map<int, vector<pair<int, int>>> valueToPositions;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                valueToPositions[mat[i][j]].emplace_back(i, j);
            }
        }

        vector<int> rowMax(m, 0);
        vector<int> colMax(n, 0);
        vector<vector<int>> dp(m, vector<int>(n, 0));

        for (auto& [val, positions] : valueToPositions) {
            for (auto& [i, j] : positions) {
                dp[i][j] = max(rowMax[i], colMax[j]) + 1;
            }
            for (auto& [i, j] : positions) {
                rowMax[i] = max(rowMax[i], dp[i][j]);
                colMax[j] = max(colMax[j], dp[i][j]);
            }
        }

        return *max_element(rowMax.begin(), rowMax.end());
    }
};