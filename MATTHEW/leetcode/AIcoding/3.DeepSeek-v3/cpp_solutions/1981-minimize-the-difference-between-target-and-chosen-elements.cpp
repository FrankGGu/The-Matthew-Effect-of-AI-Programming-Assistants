class Solution {
public:
    int minimizeTheDifference(vector<vector<int>>& mat, int target) {
        int m = mat.size(), n = mat[0].size();
        bitset<4901> dp;
        dp[0] = 1;
        for (int i = 0; i < m; ++i) {
            bitset<4901> ndp;
            for (int j = 0; j < n; ++j) {
                int num = mat[i][j];
                ndp |= dp << num;
            }
            dp = ndp;
        }
        int res = INT_MAX;
        for (int i = 0; i <= 4900; ++i) {
            if (dp[i]) {
                res = min(res, abs(i - target));
            }
        }
        return res;
    }
};