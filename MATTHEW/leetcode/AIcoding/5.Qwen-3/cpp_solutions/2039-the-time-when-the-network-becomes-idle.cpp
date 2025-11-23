#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int networkBecomesIdle(vector<vector<int>>& edges, int patience) {
        int n = edges.size() + 1;
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dist(n, INT_MAX);
        queue<int> q;
        q.push(0);
        dist[0] = 0;

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                if (dist[neighbor] == INT_MAX) {
                    dist[neighbor] = dist[node] + 1;
                    q.push(neighbor);
                }
            }
        }

        int maxTime = 0;
        for (int i = 1; i < n; ++i) {
            int time = dist[i] * 2;
            if (patience != 0) {
                int fullCycles = (time - 1) / patience;
                time = fullCycles * patience + time;
            }
            maxTime = max(maxTime, time);
        }

        return maxTime;
    }
};