class Solution {
public:
    int collectTheCoins(vector<int>& coins, vector<vector<int>>& edges) {
        int n = coins.size();
        vector<unordered_set<int>> graph(n);
        for (auto& e : edges) {
            graph[e[0]].insert(e[1]);
            graph[e[1]].insert(e[0]);
        }

        queue<int> leaves;
        for (int i = 0; i < n; ++i) {
            if (graph[i].size() == 1) {
                leaves.push(i);
            }
        }

        int steps = 0;
        vector<int> dist(n, 0);
        while (!leaves.empty()) {
            int u = leaves.front();
            leaves.pop();
            if (graph[u].empty()) continue;
            int v = *graph[u].begin();
            graph[u].erase(v);
            graph[v].erase(u);
            if (coins[u]) {
                dist[v] = max(dist[v], dist[u] + 1);
            } else {
                dist[v] = max(dist[v], dist[u]);
            }
            if (graph[v].size() == 1) {
                leaves.push(v);
            }
        }

        int res = 0;
        for (auto& e : edges) {
            int u = e[0], v = e[1];
            if (dist[u] >= 2 && dist[v] >= 2) {
                res += 2;
            }
        }
        return res;
    }
};