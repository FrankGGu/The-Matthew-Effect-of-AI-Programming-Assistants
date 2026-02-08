class Solution {
public:
    int mostProfitablePath(vector<vector<int>>& edges, int bob, vector<int>& amount) {
        int n = amount.size();
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> parent(n, -1);
        vector<int> depth(n, 0);
        queue<int> q;
        q.push(0);
        parent[0] = -1;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : adj[u]) {
                if (parent[v] == -1 && v != parent[u]) {
                    parent[v] = u;
                    depth[v] = depth[u] + 1;
                    q.push(v);
                }
            }
        }

        vector<int> bob_time(n, INT_MAX);
        int time = 0;
        int u = bob;
        while (u != -1) {
            bob_time[u] = time;
            u = parent[u];
            time++;
        }

        q.push(0);
        vector<int> alice_profit(n, INT_MIN);
        alice_profit[0] = 0;

        if (bob_time[0] == 0) {
            alice_profit[0] = amount[0] / 2;
        } else {
            alice_profit[0] = amount[0];
        }

        while (!q.empty()) {
            u = q.front();
            q.pop();
            for (int v : adj[u]) {
                if (v != parent[u] && alice_profit[v] == INT_MIN) {
                    int t = depth[v];
                    if (bob_time[v] == t) {
                        alice_profit[v] = alice_profit[u] + amount[v] / 2;
                    } else if (bob_time[v] > t) {
                        alice_profit[v] = alice_profit[u] + amount[v];
                    } else {
                        alice_profit[v] = alice_profit[u];
                    }
                    q.push(v);
                }
            }
        }

        int res = INT_MIN;
        for (int i = 0; i < n; ++i) {
            if (adj[i].size() == 1 && i != 0) {
                res = max(res, alice_profit[i]);
            }
        }
        return res;
    }
};