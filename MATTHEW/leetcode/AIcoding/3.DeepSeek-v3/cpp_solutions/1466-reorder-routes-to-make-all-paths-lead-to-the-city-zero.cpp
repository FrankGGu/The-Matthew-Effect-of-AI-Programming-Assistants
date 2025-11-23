class Solution {
public:
    int minReorder(int n, vector<vector<int>>& connections) {
        vector<vector<pair<int, bool>>> adj(n);
        for (auto& conn : connections) {
            adj[conn[0]].emplace_back(conn[1], true);
            adj[conn[1]].emplace_back(conn[0], false);
        }

        queue<int> q;
        vector<bool> visited(n, false);
        q.push(0);
        visited[0] = true;
        int res = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (auto& [v, is_original] : adj[u]) {
                if (!visited[v]) {
                    if (is_original) {
                        res++;
                    }
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        return res;
    }
};