class Solution {
public:
    int catMouseGame(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<vector<vector<int>>> dp(2 * n, vector<vector<int>>(n, vector<int>(n, -1)));
        return helper(graph, 0, 1, 2, dp);
    }

    int helper(vector<vector<int>>& graph, int t, int mouse, int cat, vector<vector<vector<int>>>& dp) {
        if (t == 2 * graph.size()) return 0;
        if (mouse == cat) return dp[t][mouse][cat] = 2;
        if (mouse == 0) return dp[t][mouse][cat] = 1;
        if (dp[t][mouse][cat] != -1) return dp[t][mouse][cat];

        bool mouseTurn = (t % 2 == 0);
        if (mouseTurn) {
            bool canDraw = false;
            for (int next : graph[mouse]) {
                int res = helper(graph, t + 1, next, cat, dp);
                if (res == 1) return dp[t][mouse][cat] = 1;
                if (res == 0) canDraw = true;
            }
            if (canDraw) return dp[t][mouse][cat] = 0;
            else return dp[t][mouse][cat] = 2;
        } else {
            bool canDraw = false;
            for (int next : graph[cat]) {
                if (next == 0) continue;
                int res = helper(graph, t + 1, mouse, next, dp);
                if (res == 2) return dp[t][mouse][cat] = 2;
                if (res == 0) canDraw = true;
            }
            if (canDraw) return dp[t][mouse][cat] = 0;
            else return dp[t][mouse][cat] = 1;
        }
    }
};