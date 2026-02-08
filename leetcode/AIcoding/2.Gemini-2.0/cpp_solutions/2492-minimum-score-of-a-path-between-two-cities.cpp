#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minScore(int n, vector<vector<int>>& roads) {
        vector<vector<pair<int, int>>> adj(n + 1);
        for (auto& road : roads) {
            adj[road[0]].push_back({road[1], road[2]});
            adj[road[1]].push_back({road[0], road[2]});
        }

        vector<bool> visited(n + 1, false);
        queue<int> q;
        q.push(1);
        visited[1] = true;

        int min_dist = INT_MAX;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int dist = edge.second;

                min_dist = min(min_dist, dist);

                if (!visited[v]) {
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        return min_dist;
    }
};