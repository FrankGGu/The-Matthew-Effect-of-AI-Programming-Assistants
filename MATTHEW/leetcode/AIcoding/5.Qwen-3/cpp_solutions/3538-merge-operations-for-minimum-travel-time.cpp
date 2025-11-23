#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minTravelTime(vector<int>& stations, vector<vector<int>>& connections) {
        int n = stations.size();
        vector<vector<pair<int, int>>> graph(n);

        for (const auto& conn : connections) {
            int u = conn[0], v = conn[1], time = conn[2];
            graph[u].push_back({v, time});
            graph[v].push_back({u, time});
        }

        vector<int> dist(n, INT_MAX);
        dist[0] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, 0});

        while (!pq.empty()) {
            int current_time = pq.top().first;
            int current_station = pq.top().second;
            pq.pop();

            if (current_time > dist[current_station]) continue;

            for (const auto& neighbor : graph[current_station]) {
                int next_station = neighbor.first;
                int travel_time = neighbor.second;
                int new_time = current_time + travel_time + stations[next_station];

                if (new_time < dist[next_station]) {
                    dist[next_station] = new_time;
                    pq.push({new_time, next_station});
                }
            }
        }

        return dist[n - 1];
    }
};