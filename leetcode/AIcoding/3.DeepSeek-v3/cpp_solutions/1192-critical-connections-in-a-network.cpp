class Solution {
public:
    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {
        vector<vector<int>> graph(n);
        for (auto& conn : connections) {
            graph[conn[0]].push_back(conn[1]);
            graph[conn[1]].push_back(conn[0]);
        }

        vector<int> disc(n, -1), low(n, -1);
        vector<vector<int>> res;
        int time = 0;

        function<void(int, int)> dfs = [&](int u, int parent) {
            disc[u] = low[u] = time++;
            for (int v : graph[u]) {
                if (v == parent) continue;
                if (disc[v] == -1) {
                    dfs(v, u);
                    low[u] = min(low[u], low[v]);
                    if (low[v] > disc[u]) {
                        res.push_back({u, v});
                    }
                } else {
                    low[u] = min(low[u], disc[v]);
                }
            }
        };

        dfs(0, -1);
        return res;
    }
};