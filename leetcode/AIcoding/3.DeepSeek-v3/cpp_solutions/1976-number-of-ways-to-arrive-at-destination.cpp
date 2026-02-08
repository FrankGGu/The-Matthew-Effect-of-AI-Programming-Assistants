#include <vector>
#include <queue>
#include <climits>
using namespace std;

class Solution {
public:
    int countPaths(int n, vector<vector<int>>& roads) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& road : roads) {
            int u = road[0], v = road[1], time = road[2];
            graph[u].emplace_back(v, time);
            graph[v].emplace_back(u, time);
        }

        vector<long long> dist(n, LONG_MAX);
        vector<long long> ways(n, 0);
        dist[0] = 0;
        ways[0] = 1;

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
        pq.emplace(0, 0);

        long long MOD = 1e9 + 7;

        while (!pq.empty()) {
            auto [current_dist, u] = pq.top();
            pq.pop();

            if (current_dist > dist[u]) continue;

            for (auto& [v, time] : graph[u]) {
                if (dist[v] > current_dist + time) {
                    dist[v] = current_dist + time;
                    ways[v] = ways[u];
                    pq.emplace(dist[v], v);
                } else if (dist[v] == current_dist + time) {
                    ways[v] = (ways[v] + ways[u]) % MOD;
                }
            }
        }

        return ways[n - 1];
    }
};