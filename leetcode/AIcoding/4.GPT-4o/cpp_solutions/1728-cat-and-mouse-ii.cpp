class Solution {
public:
    int catMouseGame(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(2 * n, -1)));
        return dfs(graph, 0, 1, 0, dp);
    }

    int dfs(vector<vector<int>>& graph, int cat, int mouse, int turns, vector<vector<vector<int>>>& dp) {
        if (turns == 2 * graph.size()) return 0;
        if (cat == mouse) return 2; 
        if (cat == 0) return 1; 

        if (dp[cat][mouse][turns] != -1) return dp[cat][mouse][turns];

        int result = (turns % 2 == 0) ? 2 : 0; 
        int nextPlayer = (turns % 2 == 0) ? cat : mouse;
        vector<int>& nextMoves = graph[nextPlayer];

        for (int next : nextMoves) {
            if (turns % 2 == 0) {
                if (next != 0) {
                    result = min(result, dfs(graph, next, mouse, turns + 1, dp));
                }
            } else {
                result = max(result, dfs(graph, cat, next, turns + 1, dp));
            }
        }

        return dp[cat][mouse][turns] = result;
    }
};