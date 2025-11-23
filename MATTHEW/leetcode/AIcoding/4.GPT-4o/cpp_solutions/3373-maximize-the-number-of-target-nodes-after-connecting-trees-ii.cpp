class Solution {
public:
    int maximizeTheProfit(int n, vector<vector<int>>& edges, vector<int>& price) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dp(n, -1);
        function<int(int, int)> dfs = [&](int node, int parent) {
            if (dp[node] != -1) return dp[node];
            int include = price[node], exclude = 0;
            for (int neighbor : graph[node]) {
                if (neighbor == parent) continue;
                exclude += dfs(neighbor, node);
                if (exclude > 0) include += exclude;
            }
            return dp[node] = max(include, exclude);
        };

        return dfs(0, -1);
    }
};