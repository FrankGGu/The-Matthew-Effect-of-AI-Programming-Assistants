class Solution {
public:
    int countCompleteComponents(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        int count = 0;

        function<pair<int, int>(int)> dfs = [&](int u) {
            visited[u] = true;
            int nodes = 1;
            int edges_count = adj[u].size();

            for (int v : adj[u]) {
                if (!visited[v]) {
                    auto result = dfs(v);
                    nodes += result.first;
                    edges_count += result.second;
                }
            }
            return make_pair(nodes, edges_count);
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                auto component = dfs(i);
                int nodes = component.first;
                int edges_count = component.second;

                if (edges_count == (long long)nodes * (nodes - 1)) {
                    count++;
                }
            }
        }

        return count;
    }
};