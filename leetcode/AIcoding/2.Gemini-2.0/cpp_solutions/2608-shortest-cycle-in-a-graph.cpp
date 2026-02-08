#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int shortestCycle(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        int minCycle = INT_MAX;

        for (int startNode = 0; startNode < n; ++startNode) {
            vector<int> dist(n, -1);
            vector<int> parent(n, -1);
            queue<int> q;

            dist[startNode] = 0;
            q.push(startNode);

            while (!q.empty()) {
                int u = q.front();
                q.pop();

                for (int v : adj[u]) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        parent[v] = u;
                        q.push(v);
                    } else if (parent[u] != v && parent[v] != u) {
                        minCycle = min(minCycle, dist[u] + dist[v] + 1);
                    }
                }
            }
        }

        return (minCycle == INT_MAX) ? -1 : minCycle;
    }
};