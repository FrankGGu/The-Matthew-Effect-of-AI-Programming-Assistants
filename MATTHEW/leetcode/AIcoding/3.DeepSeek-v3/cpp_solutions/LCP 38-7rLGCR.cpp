class Solution {
public:
    int guardCastle(vector<string>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        int INF = 1e9;
        vector<vector<int>> dp(n + 1, vector<int>(4, INF));
        dp[0][0] = 0;

        for (int j = 0; j < n; ++j) {
            for (int mask = 0; mask < 4; ++mask) {
                if (dp[j][mask] == INF) continue;
                for (int new_mask = 0; new_mask < 4; ++new_mask) {
                    bool valid = true;
                    int cost = 0;
                    for (int i = 0; i < 2; ++i) {
                        char c = grid[i][j];
                        int prev = (mask >> i) & 1;
                        int curr = (new_mask >> i) & 1;
                        if (c == 'C' && curr == 0) valid = false;
                        if (c == 'S' && curr == 1) valid = false;
                        if (c == '.' && curr != prev) {
                            if (curr == 1) cost += 1;
                            else valid = false;
                        }
                    }
                    if (valid) {
                        if ((new_mask & 1) && (new_mask & 2)) valid = false;
                        if (valid) {
                            dp[j + 1][new_mask] = min(dp[j + 1][new_mask], dp[j][mask] + cost);
                        }
                    }
                }
            }
        }

        int res = INF;
        for (int mask = 0; mask < 4; ++mask) {
            res = min(res, dp[n][mask]);
        }
        return res == INF ? -1 : res;
    }
};