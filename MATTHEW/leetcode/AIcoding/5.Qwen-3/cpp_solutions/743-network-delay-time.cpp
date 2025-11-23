#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int networkDelayTime(vector<vector<int>>& times, int n, int k) {
        vector<vector<pair<int, int>>> graph(n + 1);
        for (auto& time : times) {
            graph[time[0]].push_back({time[1], time[2]});
        }

        vector<int> dist(n + 1, INT_MAX);
        dist[k] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, k});

        while (!pq.empty()) {
            auto [time, node] = pq.top();
            pq.pop();
            if (time > dist[node]) continue;
            for (auto& [neighbor, delay] : graph[node]) {
                if (dist[neighbor] > dist[node] + delay) {
                    dist[neighbor] = dist[node] + delay;
                    pq.push({dist[neighbor], neighbor});
                }
            }
        }

        int max_time = 0;
        for (int i = 1; i <= n; ++i) {
            if (dist[i] == INT_MAX) return -1;
            max_time = max(max_time, dist[i]);
        }
        return max_time;
    }
};