class Solution {
public:
    const int MOD = 1e9 + 7;
    int countRoutes(vector<int>& locations, int start, int finish, int fuel) {
        int n = locations.size();
        vector<vector<int>> dp(n, vector<int>(fuel + 1, -1));
        return dfs(locations, start, finish, fuel, dp);
    }

    int dfs(vector<int>& locations, int u, int finish, int fuel, vector<vector<int>>& dp) {
        if (fuel < 0) return 0;
        if (dp[u][fuel] != -1) return dp[u][fuel];

        int res = (u == finish) ? 1 : 0;
        for (int v = 0; v < locations.size(); ++v) {
            if (v == u) continue;
            int cost = abs(locations[u] - locations[v]);
            if (fuel >= cost) {
                res = (res + dfs(locations, v, finish, fuel - cost, dp)) % MOD;
            }
        }
        return dp[u][fuel] = res;
    }
};