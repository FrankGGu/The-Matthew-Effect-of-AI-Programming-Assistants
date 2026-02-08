class Solution {
public:
    int maxSum(vector<vector<int>>& edges, vector<int>& values) {
        int n = values.size();
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            adj[u].emplace_back(v, values[u] + values[v]);
            adj[v].emplace_back(u, values[u] + values[v]);
        }

        int res = 0;
        for (int u = 0; u < n; ++u) {
            if (adj[u].size() < 2) continue;
            sort(adj[u].begin(), adj[u].end(), [](const pair<int, int>& a, const pair<int, int>& b) {
                return a.second > b.second;
            });
            for (int i = 0; i < min(2, (int)adj[u].size()); ++i) {
                for (int j = i + 1; j < adj[u].size(); ++j) {
                    int v1 = adj[u][i].first, v2 = adj[u][j].first;
                    if (v1 == v2) continue;
                    int sum = adj[u][i].second + adj[u][j].second;
                    if (u != v1 && u != v2 && v1 != v2) {
                        sum -= values[u];
                    }
                    res = max(res, sum);
                }
            }
        }
        return res;
    }
};