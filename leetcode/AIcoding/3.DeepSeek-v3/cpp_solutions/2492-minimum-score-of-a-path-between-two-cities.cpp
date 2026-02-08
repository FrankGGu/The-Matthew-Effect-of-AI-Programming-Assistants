class Solution {
public:
    int minScore(int n, vector<vector<int>>& roads) {
        vector<vector<pair<int, int>>> graph(n + 1);
        for (auto& road : roads) {
            int u = road[0], v = road[1], w = road[2];
            graph[u].emplace_back(v, w);
            graph[v].emplace_back(u, w);
        }

        int res = INT_MAX;
        vector<bool> visited(n + 1, false);
        queue<int> q;
        q.push(1);
        visited[1] = true;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (auto& [v, w] : graph[u]) {
                res = min(res, w);
                if (!visited[v]) {
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        return res;
    }
};