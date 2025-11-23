class Solution {
public:
    int maximizeTheProfit(int n, vector<vector<int>>& edges, vector<int>& price) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dp(n, 0);
        vector<bool> visited(n, false);

        function<int(int)> dfs = [&](int node) {
            visited[node] = true;
            int totalProfit = price[node];
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    totalProfit += dfs(neighbor);
                }
            }
            return totalProfit;
        };

        int maxProfit = 0;
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                maxProfit = max(maxProfit, dfs(i));
            }
        }
        return maxProfit;
    }
};