#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostProfitablePath(vector<vector<int>>& edges, int bob, vector<int>& amount) {
        int n = amount.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> bobPath(n, -1);
        vector<int> parent(n, -1);
        queue<int> q;
        q.push(bob);
        bobPath[bob] = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                if (bobPath[v] == -1) {
                    bobPath[v] = bobPath[u] + 1;
                    parent[v] = u;
                    q.push(v);
                }
            }
        }

        int curr = 0;
        int bobTime = bobPath[0];
        while (curr != bob) {
            if (bobTime == bobPath[curr]) {
                amount[curr] = 0;
            } else if (bobTime > bobPath[curr]) {
                amount[curr] /= 2;
            }
            curr = parent[curr];
            bobTime--;
        }
        if (bobTime == bobPath[curr]) {
            amount[curr] = 0;
        } else if (bobTime > bobPath[curr]) {
            amount[curr] /= 2;
        }

        int maxProfit = -1e9;
        vector<int> dist(n, -1);
        q = queue<int>();
        q.push(0);
        dist[0] = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            bool isLeaf = true;
            for (int v : adj[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                    isLeaf = false;
                }
            }

            if (isLeaf) {
                int profit = 0;
                vector<bool> visited(n, false);
                q = queue<int>();
                q.push(u);
                visited[u] = true;

                function<void(int, int)> dfs = [&](int node, int currentProfit) {
                    if (adj[node].size() == 1 && node != 0) {
                        maxProfit = max(maxProfit, currentProfit);
                        return;
                    }

                    for (int neighbor : adj[node]) {
                        if (!visited[neighbor]) {
                            visited[neighbor] = true;
                            dfs(neighbor, currentProfit + amount[neighbor]);
                            visited[neighbor] = false;
                        }
                    }
                };

                dfs(u, amount[u]);

            }
        }

        function<void(int, int, int)> dfs = [&](int u, int p, int currentProfit) {
            bool isLeaf = true;
            for (int v : adj[u]) {
                if (v != p) {
                    isLeaf = false;
                    dfs(v, u, currentProfit + amount[v]);
                }
            }
            if (isLeaf) {
                maxProfit = max(maxProfit, currentProfit);
            }
        };

        maxProfit = -1e9;
        dfs(0, -1, amount[0]);

        return maxProfit;
    }
};