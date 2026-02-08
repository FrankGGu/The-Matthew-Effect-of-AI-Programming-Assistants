#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int countPaths(int n, vector<vector<int>>& roads) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& road : roads) {
            adj[road[0]].push_back({road[1], road[2]});
            adj[road[1]].push_back({road[0], road[2]});
        }

        vector<long long> dist(n, LONG_MAX);
        vector<long long> count(n, 0);
        dist[0] = 0;
        count[0] = 1;

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<>> pq;
        pq.push({0, 0});

        while (!pq.empty()) {
            long long d = pq.top().first;
            int node = pq.top().second;
            pq.pop();

            if (d > dist[node]) continue;

            for (auto& neighbor : adj[node]) {
                int nextNode = neighbor.first;
                long long weight = neighbor.second;

                if (dist[nextNode] > dist[node] + weight) {
                    dist[nextNode] = dist[node] + weight;
                    count[nextNode] = count[node];
                    pq.push({dist[nextNode], nextNode});
                } else if (dist[nextNode] == dist[node] + weight) {
                    count[nextNode] = (count[nextNode] + count[node]) % 1000000007;
                }
            }
        }

        return count[n - 1];
    }
};