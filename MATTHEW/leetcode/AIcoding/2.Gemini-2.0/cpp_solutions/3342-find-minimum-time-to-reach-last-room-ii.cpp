#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

long long findMinimumTime(vector<vector<int>>& edges, int n, int start, int target, int time) {
    vector<vector<pair<int, int>>> adj(n + 1);
    for (auto& edge : edges) {
        adj[edge[0]].push_back({edge[1], edge[2]});
        adj[edge[1]].push_back({edge[0], edge[2]});
    }

    vector<long long> dist(n + 1, -1);
    priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
    dist[start] = 0;
    pq.push({0, start});

    while (!pq.empty()) {
        long long d = pq.top().first;
        int u = pq.top().second;
        pq.pop();

        if (d > dist[u]) continue;

        for (auto& edge : adj[u]) {
            int v = edge.first;
            int w = edge.second;
            long long wait = 0;

            if (d % time != 0) {
                wait = time - (d % time);
            }

            if (dist[v] == -1 || dist[v] > d + wait + w) {
                dist[v] = d + wait + w;
                pq.push({dist[v], v});
            }
        }
    }

    return dist[target];
}