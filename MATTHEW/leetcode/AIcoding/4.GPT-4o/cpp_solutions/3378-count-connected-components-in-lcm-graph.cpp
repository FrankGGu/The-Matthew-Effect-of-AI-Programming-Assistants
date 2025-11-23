class Solution {
public:
    int countComponents(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        int components = 0;

        function<void(int)> dfs = [&](int node) {
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    dfs(neighbor);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                visited[i] = true;
                dfs(i);
                components++;
            }
        }

        return components;
    }
};