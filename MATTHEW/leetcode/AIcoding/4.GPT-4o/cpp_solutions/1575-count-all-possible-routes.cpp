class Solution {
public:
    int countRoutes(vector<int>& locations, int start, int finish, int fuel) {
        int n = locations.size();
        vector<vector<int>> dp(n, vector<int>(fuel + 1, -1));
        return dfs(locations, start, finish, fuel, dp);
    }

    int dfs(vector<int>& locations, int curr, int finish, int fuel, vector<vector<int>>& dp) {
        if (fuel < 0) return 0;
        if (dp[curr][fuel] != -1) return dp[curr][fuel];

        int count = (curr == finish) ? 1 : 0;
        for (int next = 0; next < locations.size(); ++next) {
            if (next != curr) {
                int cost = abs(locations[next] - locations[curr]);
                count = (count + dfs(locations, next, finish, fuel - cost, dp)) % 1000000007;
            }
        }

        return dp[curr][fuel] = count;
    }
};