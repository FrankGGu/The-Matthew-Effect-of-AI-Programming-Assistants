class Solution {
public:
    int numSubmat(vector<vector<int>>& mat) {
        int m = mat.size();
        if (m == 0) return 0;
        int n = mat[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        int res = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (mat[i][j] == 1) {
                    if (j == 0) {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = dp[i][j-1] + 1;
                    }
                    int min_val = dp[i][j];
                    for (int k = i; k >= 0; --k) {
                        min_val = min(min_val, dp[k][j]);
                        res += min_val;
                        if (min_val == 0) break;
                    }
                }
            }
        }
        return res;
    }
};