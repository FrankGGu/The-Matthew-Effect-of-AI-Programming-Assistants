class Solution {
public:
    int getMaxGridHappiness(int m, int n, int x, int y, int newPeople, int happy, int sad) {
        vector<vector<int>> dp(1 << (m * n), vector<int>(3, -1));
        return dfs(0, 0, 0, m, n, x, y, newPeople, happy, sad, dp);
    }

private:
    int dfs(int mask, int idx, int count, int m, int n, int x, int y, int newPeople, int happy, int sad, vector<vector<int>>& dp) {
        if (count == newPeople) return 0;
        if (idx >= m * n) return 0;
        if (dp[mask][count] != -1) return dp[mask][count];

        int res = dfs(mask, idx + 1, count, m, n, x, y, newPeople, happy, sad, dp);
        if (canPlace(mask, idx, m, n)) {
            int newMask = mask | (1 << idx);
            res = max(res, happy + dfs(newMask, idx + 1, count + 1, m, n, x, y, newPeople, happy, sad, dp) + getAdjacentHappiness(newMask, m, n, x, y, sad));
        }
        return dp[mask][count] = res;
    }

    bool canPlace(int mask, int idx, int m, int n) {
        if (mask & (1 << idx)) return false;
        int x = idx / n, y = idx % n;
        for (int dx = -1; dx <= 1; ++dx) {
            for (int dy = -1; dy <= 1; ++dy) {
                if (abs(dx) + abs(dy) == 1) {
                    int nx = x + dx, ny = y + dy;
                    if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                        if (mask & (1 << (nx * n + ny))) return false;
                    }
                }
            }
        }
        return true;
    }

    int getAdjacentHappiness(int mask, int m, int n, int x, int y, int sad) {
        int total = 0;
        for (int i = 0; i < m * n; ++i) {
            if (mask & (1 << i)) {
                int cx = i / n, cy = i % n;
                for (int dx = -1; dx <= 1; ++dx) {
                    for (int dy = -1; dy <= 1; ++dy) {
                        if (abs(dx) + abs(dy) == 1) {
                            int nx = cx + dx, ny = cy + dy;
                            if (nx >= 0 && nx < m && ny >= 0 && ny < n && (mask & (1 << (nx * n + ny)))) {
                                total -= sad;
                            }
                        }
                    }
                }
            }
        }
        return total;
    }
};