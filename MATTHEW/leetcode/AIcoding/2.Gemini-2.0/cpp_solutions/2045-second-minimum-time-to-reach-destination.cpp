#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int secondMinimum(int n, vector<vector<int>>& edges, int time, int change) {
        vector<vector<int>> adj(n + 1);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<vector<int>> dist(n + 1, vector<int>(2, 1e9));
        dist[1][0] = 0;

        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.emplace(0, 1, 0);

        while (!pq.empty()) {
            auto [d, u, type] = pq.top();
            pq.pop();

            if (d > dist[u][type]) continue;

            for (int v : adj[u]) {
                int new_dist = d + time;
                int cycles = new_dist / change;
                if (cycles % 2 != 0) {
                    new_dist += (change - (new_dist % change));
                }

                if (new_dist < dist[v][0]) {
                    dist[v][1] = dist[v][0];
                    dist[v][0] = new_dist;
                    pq.emplace(dist[v][0], v, 0);
                    pq.emplace(dist[v][1], v, 1);
                } else if (new_dist > dist[v][0] && new_dist < dist[v][1]) {
                    dist[v][1] = new_dist;
                    pq.emplace(dist[v][1], v, 1);
                }
            }
        }

        return dist[n][1];
    }
};