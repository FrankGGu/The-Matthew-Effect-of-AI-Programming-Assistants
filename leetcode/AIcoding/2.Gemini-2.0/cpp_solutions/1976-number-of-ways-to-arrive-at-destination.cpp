#include <vector>
#include <queue>

using namespace std;

int countPaths(int n, vector<vector<int>>& roads) {
    vector<vector<pair<int, int>>> adj(n);
    for (auto& road : roads) {
        int u = road[0];
        int v = road[1];
        int time = road[2];
        adj[u].push_back({v, time});
        adj[v].push_back({u, time});
    }

    vector<long long> dist(n, LLONG_MAX);
    vector<int> ways(n, 0);
    dist[0] = 0;
    ways[0] = 1;

    priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
    pq.push({0, 0});

    while (!pq.empty()) {
        long long d = pq.top().first;
        int u = pq.top().second;
        pq.pop();

        if (d > dist[u]) continue;

        for (auto& edge : adj[u]) {
            int v = edge.first;
            int time = edge.second;

            if (dist[u] + time < dist[v]) {
                dist[v] = dist[u] + time;
                ways[v] = ways[u];
                pq.push({dist[v], v});
            } else if (dist[u] + time == dist[v]) {
                ways[v] = (ways[v] + ways[u]) % 1000000007;
            }
        }
    }

    return ways[n - 1];
}