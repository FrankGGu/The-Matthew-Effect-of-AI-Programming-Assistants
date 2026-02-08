class Solution {
public:
    int catMouseGame(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(2, -1)));

        function<int(int, int, int)> dfs = [&](int cat, int mouse, int turn) {
            if (dp[cat][mouse][turn] != -1) {
                return dp[cat][mouse][turn];
            }
            if (turn == 0) {
                if (cat == mouse) return dp[cat][mouse][turn] = 2;
                for (int next : graph[cat]) {
                    int result = dfs(next, mouse, 1);
                    if (result == 2) return dp[cat][mouse][turn] = 2;
                }
                return dp[cat][mouse][turn] = 1;
            } else {
                if (mouse == 0) return dp[cat][mouse][turn] = 1;
                for (int next : graph[mouse]) {
                    int result = dfs(cat, next, 0);
                    if (result == 1) return dp[cat][mouse][turn] = 1;
                }
                return dp[cat][mouse][turn] = 2;
            }
        };

        return dfs(1, 2, 0);
    }
};