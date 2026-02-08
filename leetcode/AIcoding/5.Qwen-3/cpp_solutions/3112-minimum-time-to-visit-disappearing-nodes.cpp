#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumTimeToVisitDisappearingNodes(vector<vector<int>>& edges, vector<int>& nodeTime) {
        int n = nodeTime.size();
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1], t = edge[2];
            graph[u].emplace_back(v, t);
            graph[v].emplace_back(u, t);
        }

        vector<int> time(n, INT_MAX);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.emplace(0, 0);
        time[0] = 0;

        while (!pq.empty()) {
            auto [current_time, u] = pq.top();
            pq.pop();

            if (current_time > time[u]) continue;

            for (auto [v, t] : graph[u]) {
                int new_time = current_time + t;
                if (new_time < time[v]) {
                    time[v] = new_time;
                    pq.emplace(new_time, v);
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (time[i] != INT_MAX) {
                result = max(result, time[i] + nodeTime[i]);
            }
        }

        return result;
    }
};