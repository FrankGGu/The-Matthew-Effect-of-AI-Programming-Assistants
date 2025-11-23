class Solution {
public:
    int minimumTotalPrice(int n, vector<vector<int>>& edges, vector<int>& price, vector<vector<int>>& trips) {
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> count(n, 0);
        for (auto& trip : trips) {
            int start = trip[0], end = trip[1];
            vector<int> parent(n, -1);
            queue<int> q;
            q.push(start);
            parent[start] = start;
            while (!q.empty()) {
                int u = q.front();
                q.pop();
                if (u == end) break;
                for (int v : adj[u]) {
                    if (parent[v] == -1) {
                        parent[v] = u;
                        q.push(v);
                    }
                }
            }
            int node = end;
            while (node != parent[node]) {
                count[node]++;
                node = parent[node];
            }
            count[node]++;
        }

        vector<vector<int>> dp(n, vector<int>(2, -1));
        function<int(int, int, bool)> dfs = [&](int u, int parent, bool canHalve) {
            if (dp[u][canHalve] != -1) return dp[u][canHalve];
            int res = price[u] * count[u];
            if (canHalve) res = min(res, (price[u] / 2) * count[u]);
            int sum = 0;
            for (int v : adj[u]) {
                if (v == parent) continue;
                if (canHalve) {
                    sum += dfs(v, u, false);
                } else {
                    sum += min(dfs(v, u, true), dfs(v, u, false));
                }
            }
            res += sum;
            return dp[u][canHalve] = res;
        };

        return min(dfs(0, -1, true), dfs(0, -1, false));
    }
};