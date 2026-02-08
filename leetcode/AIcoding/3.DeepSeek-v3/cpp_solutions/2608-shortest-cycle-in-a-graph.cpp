#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int findShortestCycle(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (const auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        int min_cycle = INT_MAX;

        for (int i = 0; i < n; ++i) {
            vector<int> dist(n, -1);
            vector<int> parent(n, -1);
            queue<int> q;
            q.push(i);
            dist[i] = 0;

            while (!q.empty()) {
                int u = q.front();
                q.pop();

                for (int v : adj[u]) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        parent[v] = u;
                        q.push(v);
                    } else if (parent[u] != v && parent[v] != u) {
                        min_cycle = min(min_cycle, dist[u] + dist[v] + 1);
                    }
                }
            }
        }

        return min_cycle == INT_MAX ? -1 : min_cycle;
    }
};