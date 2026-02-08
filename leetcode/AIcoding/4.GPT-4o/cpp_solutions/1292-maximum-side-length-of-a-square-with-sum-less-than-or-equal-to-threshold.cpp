class Solution {
public:
    int maxSideLength(vector<vector<int>>& mat, int threshold) {
        int m = mat.size(), n = mat[0].size();
        vector<vector<int>> prefix(m + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefix[i][j] = mat[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
            }
        }

        int maxLen = 0;

        for (int len = 1; len <= min(m, n); len++) {
            for (int i = len; i <= m; i++) {
                for (int j = len; j <= n; j++) {
                    int sum = prefix[i][j] - prefix[i - len][j] - prefix[i][j - len] + prefix[i - len][j - len];
                    if (sum <= threshold) {
                        maxLen = len;
                    }
                }
            }
        }

        return maxLen;
    }
};