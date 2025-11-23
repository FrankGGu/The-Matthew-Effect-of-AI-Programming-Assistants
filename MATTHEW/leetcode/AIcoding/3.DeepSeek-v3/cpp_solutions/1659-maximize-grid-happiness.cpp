class Solution {
public:
    int getMaxGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
        int dp[m + 1][n + 1][introvertsCount + 1][extrovertsCount + 1][3][3];
        memset(dp, -1, sizeof(dp));

        function<int(int, int, int, int, int, int)> dfs = [&](int i, int j, int in, int ex, int prev1, int prev2) {
            if (i == m) return 0;
            if (j == n) return dfs(i + 1, 0, in, ex, 0, 0);
            if (dp[i][j][in][ex][prev1][prev2] != -1) return dp[i][j][in][ex][prev1][prev2];

            int res = dfs(i, j + 1, in, ex, prev2, 0);

            if (in > 0) {
                int add = 120;
                if (prev1 == 1) add -= 30;
                else if (prev1 == 2) add -= 20;
                if (j > 0 && prev2 == 1) add -= 30;
                else if (j > 0 && prev2 == 2) add -= 20;
                res = max(res, add + dfs(i, j + 1, in - 1, ex, prev2, 1));
            }

            if (ex > 0) {
                int add = 40;
                if (prev1 == 1) add -= 20;
                else if (prev1 == 2) add += 20;
                if (j > 0 && prev2 == 1) add -= 20;
                else if (j > 0 && prev2 == 2) add += 20;
                res = max(res, add + dfs(i, j + 1, in, ex - 1, prev2, 2));
            }

            return dp[i][j][in][ex][prev1][prev2] = res;
        };

        return dfs(0, 0, introvertsCount, extrovertsCount, 0, 0);
    }
};