#include <vector>
#include <queue>
#include <limits>

using namespace std;

class Solution {
public:
    int networkDelayTime(vector<vector<int>>& times, int n, int k) {
        vector<vector<pair<int, int>>> adj(n + 1);
        for (auto& time : times) {
            adj[time[0]].push_back({time[1], time[2]});
        }

        vector<int> dist(n + 1, numeric_limits<int>::max());
        dist[k] = 0;

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, k});

        while (!pq.empty()) {
            int d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) continue;

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int weight = edge.second;

                if (dist[v] > dist[u] + weight) {
                    dist[v] = dist[u] + weight;
                    pq.push({dist[v], v});
                }
            }
        }

        int max_delay = 0;
        for (int i = 1; i <= n; ++i) {
            if (dist[i] == numeric_limits<int>::max()) return -1;
            max_delay = max(max_delay, dist[i]);
        }

        return max_delay;
    }
};