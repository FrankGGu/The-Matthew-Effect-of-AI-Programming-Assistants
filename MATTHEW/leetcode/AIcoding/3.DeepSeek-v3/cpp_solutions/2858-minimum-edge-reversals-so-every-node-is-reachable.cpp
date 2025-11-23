#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> minEdgeReversals(int n, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> adj(n);
        for (const auto& e : edges) {
            adj[e[0]].emplace_back(e[1], 0);
            adj[e[1]].emplace_back(e[0], 1);
        }

        vector<int> res(n, 0);
        queue<pair<int, int>> q;
        q.push({0, 0});
        vector<bool> visited(n, false);
        visited[0] = true;

        while (!q.empty()) {
            auto [u, cost] = q.front();
            q.pop();
            res[0] += cost;
            for (const auto& [v, c] : adj[u]) {
                if (!visited[v]) {
                    visited[v] = true;
                    q.push({v, c});
                }
            }
        }

        q.push({0, res[0]});
        fill(visited.begin(), visited.end(), false);
        visited[0] = true;

        while (!q.empty()) {
            auto [u, total] = q.front();
            q.pop();
            res[u] = total;
            for (const auto& [v, c] : adj[u]) {
                if (!visited[v]) {
                    visited[v] = true;
                    int new_total = total + (c == 0 ? 1 : -1);
                    q.push({v, new_total});
                }
            }
        }

        return res;
    }
};