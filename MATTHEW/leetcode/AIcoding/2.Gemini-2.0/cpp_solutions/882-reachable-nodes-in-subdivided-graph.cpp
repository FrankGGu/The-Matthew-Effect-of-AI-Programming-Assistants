#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int reachableNodes(vector<vector<int>>& edges, int maxMoves, int n) {
        unordered_map<int, vector<pair<int, int>>> adj;
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        priority_queue<pair<int, int>> pq;
        pq.push({maxMoves, 0});

        unordered_map<int, int> dist;
        dist[0] = maxMoves;

        int reachableNodes = 0;
        unordered_map<long long, int> usedEdges;

        while (!pq.empty()) {
            int moves = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (moves < dist[u]) continue;

            reachableNodes++;

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                int w = neighbor.second;

                long long edgeKey = (long long)min(u, v) * (n + 1) + max(u, v);

                int canReach = min(moves, w);
                usedEdges[edgeKey] += canReach;

                if (moves > w && (dist.find(v) == dist.end() || moves - w - 1 > dist[v])) {
                    dist[v] = moves - w - 1;
                    pq.push({moves - w - 1, v});
                }
            }
        }

        int edgeNodes = 0;
        for (auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];

            long long edgeKey = (long long)min(u, v) * (n + 1) + max(u, v);
            edgeNodes += min(w, usedEdges[edgeKey]);
        }

        return reachableNodes + edgeNodes;
    }
};